Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f173.google.com ([209.85.223.173]:49320 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751200AbaCTGrN (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 20 Mar 2014 02:47:13 -0400
Received: by mail-ie0-f173.google.com with SMTP id rl12so426677iec.4
        for <linux-pci@vger.kernel.org>; Wed, 19 Mar 2014 23:47:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQX+hOUsLRrL8u_T7SPU4s3SKdUiXOHSwoswKZoBNqXGUw@mail.gmail.com>
References: <1393286367-16482-1-git-send-email-yinghai@kernel.org>
	<CAErSpo4E3Kd6Vk94NQy3Nj-Hd9WFaphoXL-eCmsaQ4KvQ-fK6Q@mail.gmail.com>
	<CAE9FiQUvU=BqPXDHC+B=zC7ZGarimLDdvHsDbVL8t8qnZLJpzw@mail.gmail.com>
	<CAErSpo6vuzaKJ-qWKfwcY_MsDhSdG9NazaYzG3=tabJerUv6mw@mail.gmail.com>
	<CAE9FiQV3bM087uhWc5oH6j_7AJim0ECwTZKD05JSe2R5KmuCAQ@mail.gmail.com>
	<CAErSpo75LCpED6T48osUkGJ5CS7tUSEmdKye0wJZVOSb_OwnQQ@mail.gmail.com>
	<CAE9FiQX+hOUsLRrL8u_T7SPU4s3SKdUiXOHSwoswKZoBNqXGUw@mail.gmail.com>
Date: Wed, 19 Mar 2014 23:47:12 -0700
Message-ID: <CAE9FiQVN9R3DJWasRqNyzNK2vOpmnRZdbp0KjnPUeMtoJXoJiQ@mail.gmail.com>
Subject: Re: [PATCH] pciehp: only wait command complete for really hotplug control
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Rajat Jain <rajatxjain@gmail.com>
Content-Type: multipart/mixed; boundary=047d7bd76d1e9ea88e04f504233e
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--047d7bd76d1e9ea88e04f504233e
Content-Type: text/plain; charset=ISO-8859-1

On Wed, Mar 19, 2014 at 8:16 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Wed, Mar 19, 2014 at 3:01 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Wed, Mar 19, 2014 at 12:18 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>>
>> I think the current pciehp design is a bit broken.  Today we perform
>> commands very synchronously:
>>
>>     pcie_write_cmd() {
>>         write Slot Control
>>         if (Command Complete supported) {
>>             wait for Command Complete
>>         }
>>     }
>>
>> The typical driver pattern would be more asynchronous, like this:
>>
>>     pcie_write_cmd() {
>>         read Slot Status
>>         if (!Command Completed) {
>>             wait for Command Complete
>>         }
>>         write Slot Control
>>     }
>>
>> With the asynchronous pattern, we would probably never wait at all
>> unless we performed two commands in immediate succession.  I wouldn't
>> be surprised if doing this asynchronously would effectively cover up
>> these hardware differences.
>
> I like this idea. Will give it a try.

It works. Please check the patch that check CC before wait/write command.

Subject: [PATCH v2] pciehp: only wait command complete for real hotplug control

On system with 16 PCI express hotplug slots, customer complain every slot
will report "Command not completed in 1000 msec" during initialization.

Intel says that we should only wait command complete only for
           Electromechanical Interlock Control
           Power Controller Control
           Power Indicator Control
           Attention Indicator Control

System with AMD/Nvidia chipset have same problem.

Two ways to address the problem:
1. change to only wait when (EIC, PCC, PIC, AIC) bits get changed.
2. or check CMD_COMPLETE and wait before write command. Only wait
   when CC is set and cmd_busy is true. For chipset from intel
   will only have CC set for real hotplug control, so we could
   skip the wait for others.

This patch is using second way.

With that we could save 16 seconds during booting, later with 32 sockets system
with 64 pcie hotplug slots we could save 64 seconds.

-v2: use second way that is suggested by Bjorn.

Signed-off-by: Yinghai Lu <yinghai@kernel.org>

---
 drivers/pci/hotplug/pciehp_hpc.c |   26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

Index: linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
===================================================================
--- linux-2.6.orig/drivers/pci/hotplug/pciehp_hpc.c
+++ linux-2.6/drivers/pci/hotplug/pciehp_hpc.c
@@ -158,15 +158,8 @@ static void pcie_write_cmd(struct contro
     mutex_lock(&ctrl->ctrl_lock);

     pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &slot_status);
-    if (slot_status & PCI_EXP_SLTSTA_CC) {
-        if (!ctrl->no_cmd_complete) {
-            /*
-             * After 1 sec and CMD_COMPLETED still not set, just
-             * proceed forward to issue the next command according
-             * to spec. Just print out the error message.
-             */
-            ctrl_dbg(ctrl, "CMD_COMPLETED not clear after 1 sec\n");
-        } else if (!NO_CMD_CMPL(ctrl)) {
+    if (ctrl->no_cmd_complete && slot_status & PCI_EXP_SLTSTA_CC) {
+        if (!NO_CMD_CMPL(ctrl)) {
             /*
              * This controller seems to notify of command completed
              * event even though it supports none of power
@@ -182,16 +175,11 @@ static void pcie_write_cmd(struct contro
     }

     pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &slot_ctrl);
-    slot_ctrl &= ~mask;
-    slot_ctrl |= (cmd & mask);
-    ctrl->cmd_busy = 1;
-    smp_mb();
-    pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
-
     /*
      * Wait for command completion.
      */
-    if (!ctrl->no_cmd_complete) {
+    if (!ctrl->no_cmd_complete && (slot_status & PCI_EXP_SLTSTA_CC) &&
+        ctrl->cmd_busy) {
         int poll = 0;
         /*
          * if hotplug interrupt is not enabled or command
@@ -203,6 +191,12 @@ static void pcie_write_cmd(struct contro
             poll = 1;
                 pcie_wait_cmd(ctrl, poll);
     }
+
+    slot_ctrl &= ~mask;
+    slot_ctrl |= (cmd & mask);
+    ctrl->cmd_busy = 1;
+    smp_mb();
+    pcie_capability_write_word(pdev, PCI_EXP_SLTCTL, slot_ctrl);
     mutex_unlock(&ctrl->ctrl_lock);
 }

--047d7bd76d1e9ea88e04f504233e
Content-Type: text/x-patch; charset=US-ASCII; name="pcie_wait_cmd_next.patch"
Content-Disposition: attachment; filename="pcie_wait_cmd_next.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hszoh6qg0

U3ViamVjdDogW1BBVENIIHYyXSBwY2llaHA6IG9ubHkgd2FpdCBjb21tYW5kIGNvbXBsZXRlIGZv
ciByZWFsIGhvdHBsdWcgY29udHJvbAoKT24gc3lzdGVtIHdpdGggMTYgUENJIGV4cHJlc3MgaG90
cGx1ZyBzbG90cywgY3VzdG9tZXIgY29tcGxhaW4gZXZlcnkgc2xvdAp3aWxsIHJlcG9ydCAiQ29t
bWFuZCBub3QgY29tcGxldGVkIGluIDEwMDAgbXNlYyIgZHVyaW5nIGluaXRpYWxpemF0aW9uLgoK
SW50ZWwgc2F5cyB0aGF0IHdlIHNob3VsZCBvbmx5IHdhaXQgY29tbWFuZCBjb21wbGV0ZSBvbmx5
IGZvcgogICAgICAgICAgIEVsZWN0cm9tZWNoYW5pY2FsIEludGVybG9jayBDb250cm9sCiAgICAg
ICAgICAgUG93ZXIgQ29udHJvbGxlciBDb250cm9sCiAgICAgICAgICAgUG93ZXIgSW5kaWNhdG9y
IENvbnRyb2wKICAgICAgICAgICBBdHRlbnRpb24gSW5kaWNhdG9yIENvbnRyb2wKClN5c3RlbSB3
aXRoIEFNRC9OdmlkaWEgY2hpcHNldCBoYXZlIHNhbWUgcHJvYmxlbS4KClR3byB3YXlzIHRvIGFk
ZHJlc3MgdGhlIHByb2JsZW06CjEuIGNoYW5nZSB0byBvbmx5IHdhaXQgd2hlbiAoRUlDLCBQQ0Ms
IFBJQywgQUlDKSBiaXRzIGdldCBjaGFuZ2VkLgoyLiBvciBjaGVjayBDTURfQ09NUExFVEUgYW5k
IHdhaXQgYmVmb3JlIHdyaXRlIGNvbW1hbmQuIE9ubHkgd2FpdAogICB3aGVuIENDIGlzIHNldCBh
bmQgY21kX2J1c3kgaXMgdHJ1ZS4gRm9yIGNoaXBzZXQgZnJvbSBpbnRlbAogICB3aWxsIG9ubHkg
aGF2ZSBDQyBzZXQgZm9yIHJlYWwgaG90cGx1ZyBjb250cm9sLCBzbyB3ZSBjb3VsZAogICBza2lw
IHRoZSB3YWl0IGZvciBvdGhlcnMuCgpUaGlzIHBhdGNoIGlzIHVzaW5nIHNlY29uZCB3YXkuCgpX
aXRoIHRoYXQgd2UgY291bGQgc2F2ZSAxNiBzZWNvbmRzIGR1cmluZyBib290aW5nLCBsYXRlciB3
aXRoIDMyIHNvY2tldHMgc3lzdGVtCndpdGggNjQgcGNpZSBob3RwbHVnIHNsb3RzIHdlIGNvdWxk
IHNhdmUgNjQgc2Vjb25kcy4KCi12MjogdXNlIHNlY29uZCB3YXkgdGhhdCBpcyBzdWdnZXN0ZWQg
YnkgQmpvcm4uCgpTaWduZWQtb2ZmLWJ5OiBZaW5naGFpIEx1IDx5aW5naGFpQGtlcm5lbC5vcmc+
CgotLS0KIGRyaXZlcnMvcGNpL2hvdHBsdWcvcGNpZWhwX2hwYy5jIHwgICAyNiArKysrKysrKysr
LS0tLS0tLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKyksIDE2IGRl
bGV0aW9ucygtKQoKSW5kZXg6IGxpbnV4LTIuNi9kcml2ZXJzL3BjaS9ob3RwbHVnL3BjaWVocF9o
cGMuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYub3JpZy9kcml2ZXJzL3BjaS9ob3RwbHVnL3Bj
aWVocF9ocGMuYworKysgbGludXgtMi42L2RyaXZlcnMvcGNpL2hvdHBsdWcvcGNpZWhwX2hwYy5j
CkBAIC0xNTgsMTUgKzE1OCw4IEBAIHN0YXRpYyB2b2lkIHBjaWVfd3JpdGVfY21kKHN0cnVjdCBj
b250cm8KIAltdXRleF9sb2NrKCZjdHJsLT5jdHJsX2xvY2spOwogCiAJcGNpZV9jYXBhYmlsaXR5
X3JlYWRfd29yZChwZGV2LCBQQ0lfRVhQX1NMVFNUQSwgJnNsb3Rfc3RhdHVzKTsKLQlpZiAoc2xv
dF9zdGF0dXMgJiBQQ0lfRVhQX1NMVFNUQV9DQykgewotCQlpZiAoIWN0cmwtPm5vX2NtZF9jb21w
bGV0ZSkgewotCQkJLyoKLQkJCSAqIEFmdGVyIDEgc2VjIGFuZCBDTURfQ09NUExFVEVEIHN0aWxs
IG5vdCBzZXQsIGp1c3QKLQkJCSAqIHByb2NlZWQgZm9yd2FyZCB0byBpc3N1ZSB0aGUgbmV4dCBj
b21tYW5kIGFjY29yZGluZwotCQkJICogdG8gc3BlYy4gSnVzdCBwcmludCBvdXQgdGhlIGVycm9y
IG1lc3NhZ2UuCi0JCQkgKi8KLQkJCWN0cmxfZGJnKGN0cmwsICJDTURfQ09NUExFVEVEIG5vdCBj
bGVhciBhZnRlciAxIHNlY1xuIik7Ci0JCX0gZWxzZSBpZiAoIU5PX0NNRF9DTVBMKGN0cmwpKSB7
CisJaWYgKGN0cmwtPm5vX2NtZF9jb21wbGV0ZSAmJiBzbG90X3N0YXR1cyAmIFBDSV9FWFBfU0xU
U1RBX0NDKSB7CisJCWlmICghTk9fQ01EX0NNUEwoY3RybCkpIHsKIAkJCS8qCiAJCQkgKiBUaGlz
IGNvbnRyb2xsZXIgc2VlbXMgdG8gbm90aWZ5IG9mIGNvbW1hbmQgY29tcGxldGVkCiAJCQkgKiBl
dmVudCBldmVuIHRob3VnaCBpdCBzdXBwb3J0cyBub25lIG9mIHBvd2VyCkBAIC0xODIsMTYgKzE3
NSwxMSBAQCBzdGF0aWMgdm9pZCBwY2llX3dyaXRlX2NtZChzdHJ1Y3QgY29udHJvCiAJfQogCiAJ
cGNpZV9jYXBhYmlsaXR5X3JlYWRfd29yZChwZGV2LCBQQ0lfRVhQX1NMVENUTCwgJnNsb3RfY3Ry
bCk7Ci0Jc2xvdF9jdHJsICY9IH5tYXNrOwotCXNsb3RfY3RybCB8PSAoY21kICYgbWFzayk7Ci0J
Y3RybC0+Y21kX2J1c3kgPSAxOwotCXNtcF9tYigpOwotCXBjaWVfY2FwYWJpbGl0eV93cml0ZV93
b3JkKHBkZXYsIFBDSV9FWFBfU0xUQ1RMLCBzbG90X2N0cmwpOwotCiAJLyoKIAkgKiBXYWl0IGZv
ciBjb21tYW5kIGNvbXBsZXRpb24uCiAJICovCi0JaWYgKCFjdHJsLT5ub19jbWRfY29tcGxldGUp
IHsKKwlpZiAoIWN0cmwtPm5vX2NtZF9jb21wbGV0ZSAmJiAoc2xvdF9zdGF0dXMgJiBQQ0lfRVhQ
X1NMVFNUQV9DQykgJiYKKwkgICAgY3RybC0+Y21kX2J1c3kpIHsKIAkJaW50IHBvbGwgPSAwOwog
CQkvKgogCQkgKiBpZiBob3RwbHVnIGludGVycnVwdCBpcyBub3QgZW5hYmxlZCBvciBjb21tYW5k
CkBAIC0yMDMsNiArMTkxLDEyIEBAIHN0YXRpYyB2b2lkIHBjaWVfd3JpdGVfY21kKHN0cnVjdCBj
b250cm8KIAkJCXBvbGwgPSAxOwogICAgICAgICAgICAgICAgIHBjaWVfd2FpdF9jbWQoY3RybCwg
cG9sbCk7CiAJfQorCisJc2xvdF9jdHJsICY9IH5tYXNrOworCXNsb3RfY3RybCB8PSAoY21kICYg
bWFzayk7CisJY3RybC0+Y21kX2J1c3kgPSAxOworCXNtcF9tYigpOworCXBjaWVfY2FwYWJpbGl0
eV93cml0ZV93b3JkKHBkZXYsIFBDSV9FWFBfU0xUQ1RMLCBzbG90X2N0cmwpOwogCW11dGV4X3Vu
bG9jaygmY3RybC0+Y3RybF9sb2NrKTsKIH0KIAo=
--047d7bd76d1e9ea88e04f504233e--
