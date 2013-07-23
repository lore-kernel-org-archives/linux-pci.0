Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:42851 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933386Ab3GWXPr (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 23 Jul 2013 19:15:47 -0400
Received: by mail-ob0-f173.google.com with SMTP id er7so2942462obc.18
        for <linux-pci@vger.kernel.org>; Tue, 23 Jul 2013 16:15:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130723155645.GA18422@google.com>
References: <1374261258-23036-1-git-send-email-yinghai@kernel.org>
	<1374261258-23036-2-git-send-email-yinghai@kernel.org>
	<CAErSpo78DU3bPwkVOt=1XD08y9iD38+wUOp2+GVxO7P68TOOjg@mail.gmail.com>
	<CAE9FiQUyVUssJx8eZK9kabS99CD6ry-UnJ9q1-q+f53Fx+tjng@mail.gmail.com>
	<20130723155645.GA18422@google.com>
Date: Tue, 23 Jul 2013 16:15:46 -0700
Message-ID: <CAE9FiQUQirapRONeb1ndOoKsiYviyXJVx3wZTcgzJj7bHX-1xQ@mail.gmail.com>
Subject: Re: [PATCH] PCI: Separate stop and remove devices in pciehp
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yijing Wang <wangyijing@huawei.com>,
	Jiang Liu <liuj97@gmail.com>
Content-Type: multipart/mixed; boundary=047d7bdc1c3e11385e04e235f957
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--047d7bdc1c3e11385e04e235f957
Content-Type: text/plain; charset=ISO-8859-1

On Tue, Jul 23, 2013 at 8:56 AM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> On Mon, Jul 22, 2013 at 07:32:06PM -0700, Yinghai Lu wrote:
>> On Mon, Jul 22, 2013 at 2:23 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> > Evidently this is really part of a series, but you didn't label it
>> > that way.  It looks like this applies on top of your "PCI: Fix hotplug
>> > remove with sriov again" patch?
>>
>> Yes.
>>
>> that one need be back ported to 3.9 and later.
>>
>> this one need to be for 3.11 final, as Jiang's patch is in 3.11-rc0.
>>
>> >
>> > On Fri, Jul 19, 2013 at 1:14 PM, Yinghai Lu <yinghai@kernel.org> wrote:
>> >> After commit dc087f2f6a2925e81831f3016b9cbb6e470e7423
>> >> (PCI: Simplify IOV implementation and fix reference count races)
>> >> VF need to be removed via virtfn_remove to make sure ref to PF
>> >> is put back.
>> >
>> > I'm sure this makes sense, but it needs background.  I haven't figured
>> > out exactly what the problem is.  You're describing the lowest-level
>> > details, but not the overall picture that would make it understandable
>> > to the rest of us.
>>
>> Overall, after we reversely loop the bus_devices, VF get stop and removed,
>> but fail to release ref to PF, and prevent PF to be removed and freed.
>>
>> >
>> >> So we can not call stop_and_remove for VF before PF, that will
>> >> make VF get removed directly before PF's driver try to use
>> >> virtfn_remove to do it.
>> >>
>> >> Solution is separating stop and remove in two iterations.
>> >>
>> >> In first iteration, we stop VF driver at first with iterating devices
>> >> reversely, and later during stop PF driver, disable_sriov will use
>> >> virtfn_remove to remove VFs.
>> >>
>> >> Also some driver (like mlx4_core) need VF's driver get stopped before PF.
>> >
>> > If this is relevant, please give a pointer to the mlx4_core code that
>> > requires VFs to be stopped before the PF.
>>
>> that is add-on benefits.
>>
>> drivers/net/ethernet/mellanox/mlx4/main.c::
>> static void mlx4_remove_one(struct pci_dev *pdev)
>> {
>>         struct mlx4_dev  *dev  = pci_get_drvdata(pdev);
>>         struct mlx4_priv *priv = mlx4_priv(dev);
>>         int p;
>>
>>         if (dev) {
>>                 /* in SRIOV it is not allowed to unload the pf's
>>                  * driver while there are alive vf's */
>>                 if (mlx4_is_master(dev)) {
>>                         if (mlx4_how_many_lives_vf(dev))
>>                                 printk(KERN_ERR "Removing PF when
>> there are assigned VF's !!!\n");
>>                 }
>>
>> mlx4_how_many_lives_vf() is checking how VFs have driver loaded.
>>
>> >
>> >> To make it simple, separate VGA checking out and do that at first,
>> >> if there is VGA in the chain, do even try to stop or remove any device
>> >> under that bus.
>> >
>> > This part seems like it could be a separate patch.
>>
>> ok, will separate it out in next rev.
>>
>> >
>> >> Need this one for v3.11.
>> >
>> > OK, but why?  We need a better explanation of what problem this fixes.
>> >  It sounds like it fixes a reference counting problem in v3.11-rc1,
>> > but I don't know what the effect of that problem is.  Maybe it means a
>> > device isn't freed when it should be?  Maybe it means we can't add a
>> > new device after hot-removing an SR-IOV device?
>>
>> Yes.
>
> Can you include an example that shows the failure, like you did for
> the "Fix hotplug remove" patch?
>
>> ...
>> >> Index: linux-2.6/drivers/pci/remove.c
>> >> ===================================================================
>> >> --- linux-2.6.orig/drivers/pci/remove.c
>> >> +++ linux-2.6/drivers/pci/remove.c
>> >> @@ -56,7 +56,7 @@ void pci_remove_bus(struct pci_bus *bus)
>> >>  }
>> >>  EXPORT_SYMBOL(pci_remove_bus);
>> >>
>> >> -static void pci_stop_bus_device(struct pci_dev *dev)
>> >> +void pci_stop_bus_device(struct pci_dev *dev)
>> >>  {
>> >>         struct pci_bus *bus = dev->subordinate;
>> >>         struct pci_dev *child, *tmp;
>> >> @@ -75,8 +75,9 @@ static void pci_stop_bus_device(struct p
>> >>
>> >>         pci_stop_dev(dev);
>> >>  }
>> >> +EXPORT_SYMBOL(pci_stop_bus_device);
>> >>
>> >> -static void pci_remove_bus_device(struct pci_dev *dev)
>> >> +void pci_remove_bus_device(struct pci_dev *dev)
>> >>  {
>> >>         struct pci_bus *bus = dev->subordinate;
>> >>         struct pci_dev *child, *tmp;
>> >> @@ -92,6 +93,7 @@ static void pci_remove_bus_device(struct
>> >>
>> >>         pci_destroy_dev(dev);
>> >>  }
>> >> +EXPORT_SYMBOL(pci_remove_bus_device);
>> >
>> > I really don't want to export these two symbols unless we have to.
>> > Obviously this is the heart of your patch, so we probably *will* have
>> > to.
>>
>> Agree.
>>
>> >
>> > But maybe they can at least be confined to drivers/pci code, and not
>> > exported to modules?  I don't think there's any reason pciehp needs to
>> > be a module.  I was planning to merge a patch restricting it to be
>> > built-in this cycle anyway.
>>
>> sure, you can apply that patch (make pciehp to be built-in) at first.
>
> Below is the patch I intend to apply.  We can easily do this for v3.12.
> But your patch needs to be in v3.11, so we'll have to figure out how
> to handle that.  Maybe we can put the Kconfig change in v3.11, too.
> It should be low-risk because it doesn't add any new code paths that
> weren't in v3.10.
>
> Bjorn
>
>
> commit 04216ce0f2381090572142ebab28f63bae157d8d
> Author: Bjorn Helgaas <bhelgaas@google.com>
> Date:   Thu Jun 27 10:16:19 2013 -0600
>
>     PCI: pciehp: Convert pciehp to be builtin only, not modular
>
>     Convert pciehp to be builtin only, with no module option.
>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>
> diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
> index a82e70a..7958e59 100644
> --- a/drivers/pci/pcie/Kconfig
> +++ b/drivers/pci/pcie/Kconfig
> @@ -14,15 +14,12 @@ config PCIEPORTBUS
>  # Include service Kconfig here
>  #
>  config HOTPLUG_PCI_PCIE
> -       tristate "PCI Express Hotplug driver"
> +       bool "PCI Express Hotplug driver"
>         depends on HOTPLUG_PCI && PCIEPORTBUS
>         help
>           Say Y here if you have a motherboard that supports PCI Express Native
>           Hotplug
>
> -         To compile this driver as a module, choose M here: the
> -         module will be called pciehp.
> -
>           When in doubt, say N.
>
>  source "drivers/pci/pcie/aer/Kconfig"

on top of for-linus, please check three updated patches.

Thanks

Yinghai

--047d7bdc1c3e11385e04e235f957
Content-Type: application/octet-stream; name="fix_cx3_hotplug_5.patch"
Content-Disposition: attachment; filename="fix_cx3_hotplug_5.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hjhpzp2o0

U3ViamVjdDogW1BBVENIXSBQQ0kvcGNpZWhwOiBTZXBhcmF0ZSBWR0EgY2hlY2tpbmcgb3V0IGZy
b20gbG9vcAoKU2VwYXJhdGUgVkdBIGNoZWNraW5nIG91dCBhbmQgZG8gdGhhdCBhdCBmaXJzdCwK
aWYgdGhlcmUgaXMgVkdBIGluIHRoZSBjaGFpbiwgZG8gZXZlbiB0cnkgdG8gc3RvcCBvciByZW1v
dmUgYW55IGRldmljZQp1bmRlciB0aGF0IGJ1cy4KClNpZ25lZC1vZmYtYnk6IFlpbmdoYWkgTHUg
PHlpbmdoYWlAa2VybmVsLm9yZz4KCi0tLQogZHJpdmVycy9wY2kvaG90cGx1Zy9wY2llaHBfcGNp
LmMgfCAgIDI3ICsrKysrKysrKysrKysrKystLS0tLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDE2
IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQoKSW5kZXg6IGxpbnV4LTIuNi9kcml2ZXJz
L3BjaS9ob3RwbHVnL3BjaWVocF9wY2kuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYub3JpZy9k
cml2ZXJzL3BjaS9ob3RwbHVnL3BjaWVocF9wY2kuYworKysgbGludXgtMi42L2RyaXZlcnMvcGNp
L2hvdHBsdWcvcGNpZWhwX3BjaS5jCkBAIC05Miw2ICs5MiwyMiBAQCBpbnQgcGNpZWhwX3VuY29u
ZmlndXJlX2RldmljZShzdHJ1Y3Qgc2xvCiAJaWYgKHJldCkKIAkJcHJlc2VuY2UgPSAwOwogCisJ
LyogY2hlY2sgaWYgVkdBIGlzIGFyb3VuZCAqLworCWlmIChwcmVzZW5jZSkgeworCQlsaXN0X2Zv
cl9lYWNoX2VudHJ5KGRldiwgJnBhcmVudC0+ZGV2aWNlcywgYnVzX2xpc3QpIHsKKwkJCWlmIChk
ZXYtPmhkcl90eXBlID09IFBDSV9IRUFERVJfVFlQRV9CUklER0UpIHsKKwkJCQlwY2lfcmVhZF9j
b25maWdfYnl0ZShkZXYsIFBDSV9CUklER0VfQ09OVFJPTCwKKwkJCQkJCQkmYmN0bCk7CisJCQkJ
aWYgKGJjdGwgJiBQQ0lfQlJJREdFX0NUTF9WR0EpIHsKKwkJCQkJY3RybF9lcnIoY3RybCwKKwkJ
CQkJCSAiQ2Fubm90IHJlbW92ZSBkaXNwbGF5IGRldmljZSAlc1xuIiwKKwkJCQkJCSBwY2lfbmFt
ZShkZXYpKTsKKwkJCQkJcmV0dXJuIC1FSU5WQUw7CisJCQkJfQorCQkJfQorCQl9CisJfQorCiAJ
LyoKIAkgKiBTdG9wcGluZyBhbiBTUi1JT1YgUEYgZGV2aWNlIHJlbW92ZXMgYWxsIHRoZSBhc3Nv
Y2lhdGVkIFZGcywKIAkgKiB3aGljaCB3aWxsIHVwZGF0ZSB0aGUgYnVzLT5kZXZpY2VzIGxpc3Qg
YW5kIGNvbmZ1c2UgdGhlCkBAIC0xMDEsMTcgKzExNyw2IEBAIGludCBwY2llaHBfdW5jb25maWd1
cmVfZGV2aWNlKHN0cnVjdCBzbG8KIAlsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmVfcmV2ZXJzZShk
ZXYsIHRlbXAsICZwYXJlbnQtPmRldmljZXMsCiAJCQkJCSBidXNfbGlzdCkgewogCQlwY2lfZGV2
X2dldChkZXYpOwotCQlpZiAoZGV2LT5oZHJfdHlwZSA9PSBQQ0lfSEVBREVSX1RZUEVfQlJJREdF
ICYmIHByZXNlbmNlKSB7Ci0JCQlwY2lfcmVhZF9jb25maWdfYnl0ZShkZXYsIFBDSV9CUklER0Vf
Q09OVFJPTCwgJmJjdGwpOwotCQkJaWYgKGJjdGwgJiBQQ0lfQlJJREdFX0NUTF9WR0EpIHsKLQkJ
CQljdHJsX2VycihjdHJsLAotCQkJCQkgIkNhbm5vdCByZW1vdmUgZGlzcGxheSBkZXZpY2UgJXNc
biIsCi0JCQkJCSBwY2lfbmFtZShkZXYpKTsKLQkJCQlwY2lfZGV2X3B1dChkZXYpOwotCQkJCXJj
ID0gLUVJTlZBTDsKLQkJCQlicmVhazsKLQkJCX0KLQkJfQogCQlwY2lfc3RvcF9hbmRfcmVtb3Zl
X2J1c19kZXZpY2UoZGV2KTsKIAkJLyoKIAkJICogRW5zdXJlIHRoYXQgbm8gbmV3IFJlcXVlc3Rz
IHdpbGwgYmUgZ2VuZXJhdGVkIGZyb20K
--047d7bdc1c3e11385e04e235f957
Content-Type: application/octet-stream; name="fix_cx3_hotplug_1.patch"
Content-Disposition: attachment; filename="fix_cx3_hotplug_1.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hjhq056w1

U3ViamVjdDogW1BBVENIXSBQQ0k6IFNlcGFyYXRlIHN0b3AgYW5kIHJlbW92ZSBkZXZpY2VzIGlu
IHBjaWVocApGcm9tOiBZaW5naGFpIEx1IDx5aW5naGFpQGtlcm5lbC5vcmc+Cgpjb21taXQgZGMw
ODdmMmY2YTI5MjVlODE4MzFmMzAxNmI5Y2JiNmU0NzBlNzQyMwooUENJOiBTaW1wbGlmeSBJT1Yg
aW1wbGVtZW50YXRpb24gYW5kIGZpeCByZWZlcmVuY2UgY291bnQgcmFjZXMpCmJyb2tlIHRoZSBw
Y2llIG5hdGl2ZSBob3RwbHVnIHdpdGggU1JJT1YgZW5hYmxlZDogUEYgaXMgbm90IGZyZWVkCmR1
cmluZyBob3QtcmVtb3ZlLCBhbmQgbGF0ZXIgaG90LWFkZCBkbyBub3Qgd29yayBhcyBvbGQgcGNp
X2RldgppcyBzdGlsbCBhcm91bmQsIGFuZCBjYW4gbm90IGNyZWF0ZSBuZXcgcGNpX2Rldi4KClRo
YXQgY29tbWl0IG5lZWQgVkZzIHRvIGJlIHJlbW92ZWQgdmlhIHBjaV9kaXNhYmxlX3NyaW92L3Zp
cnRmbl9yZW1vdmUKdG8gbWFrZSBzdXJlIHJlZiB0byBQRiBpcyBwdXQgYmFjay4KClNvIHdlIGNh
biBub3QgY2FsbCBzdG9wX2FuZF9yZW1vdmUgZm9yIFZGIGJlZm9yZSBQRiwgdGhhdCB3aWxsCm1h
a2UgVkYgZ2V0IHJlbW92ZWQgZGlyZWN0bHkgYmVmb3JlIFBGJ3MgZHJpdmVyIHRyeSB0byB1c2UK
cGNpX2Rpc2FibGVfc3Jpb3YvdmlydGZuX3JlbW92ZSB0byBkbyBpdC4KClNvbHV0aW9uIGlzIHNl
cGFyYXRpbmcgc3RvcCBhbmQgcmVtb3ZlIGluIHR3byBpdGVyYXRpb25zLgoKSW4gZmlyc3QgaXRl
cmF0aW9uLCB3ZSBzdG9wIFZGIGRyaXZlciBhdCBmaXJzdCB3aXRoIGl0ZXJhdGluZyBkZXZpY2Vz
CnJldmVyc2VseSwgYW5kIGxhdGVyIGR1cmluZyBzdG9wIFBGIGRyaXZlciwgZGlzYWJsZV9zcmlv
diB3aWxsIHVzZQp2aXJ0Zm5fcmVtb3ZlIHRvIHJlbW92ZSBWRnMuCgpBbHNvIHNvbWUgZHJpdmVy
IChsaWtlIG1seDRfY29yZSkgbmVlZCBWRidzIGRyaXZlciBnZXQgc3RvcHBlZCBiZWZvcmUgUEYn
cy4KCk5lZWQgdGhpcyBvbmUgZm9yIHYzLjExLgoKLXYyOiBzZXBhcmF0ZSBWR0EgY2hlY2tpbmcg
dG8gYW5vdGhlciBwYXRjaCBhY2NvcmRpbmcgdG8gQmpvcm4uCgpTaWduZWQtb2ZmLWJ5OiBZaW5n
aGFpIEx1IDx5aW5naGFpQGtlcm5lbC5vcmc+CkNjOiBZaWppbmcgV2FuZyA8d2FuZ3lpamluZ0Bo
dWF3ZWkuY29tPgpDYzogSmlhbmcgTGl1IDxsaXVqOTdAZ21haWwuY29tPgoKLS0tCiBkcml2ZXJz
L3BjaS9ob3RwbHVnL3BjaWVocF9wY2kuYyB8ICAgMTUgKysrKysrKysrKysrKy0tCiBkcml2ZXJz
L3BjaS9wY2kuaCAgICAgICAgICAgICAgICB8ICAgIDMgKysrCiBkcml2ZXJzL3BjaS9yZW1vdmUu
YyAgICAgICAgICAgICB8ICAgIDQgKystLQogMyBmaWxlcyBjaGFuZ2VkLCAxOCBpbnNlcnRpb25z
KCspLCA0IGRlbGV0aW9ucygtKQoKSW5kZXg6IGxpbnV4LTIuNi9kcml2ZXJzL3BjaS9ob3RwbHVn
L3BjaWVocF9wY2kuYwo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0yLjYub3JpZy9kcml2ZXJzL3BjaS9o
b3RwbHVnL3BjaWVocF9wY2kuYworKysgbGludXgtMi42L2RyaXZlcnMvcGNpL2hvdHBsdWcvcGNp
ZWhwX3BjaS5jCkBAIC0xMDksNiArMTA5LDEzIEBAIGludCBwY2llaHBfdW5jb25maWd1cmVfZGV2
aWNlKHN0cnVjdCBzbG8KIAl9CiAKIAkvKgorCSAqIE5vdyBWRiBuZWVkIHRvIGJlIHJlbW92ZWQg
dmlhIHZpcnRmbl9yZW1vdmUgdG8gbWFrZQorCSAqIHN1cmUgcmVmIHRvIFBGIGlzIHB1dCBiYWNr
LiBTb21lIGRyaXZlciAobWx4NF9jb3JlKSBuZWVkCisJICogVkYncyBkcml2ZXIgZ2V0IHN0b3Bw
ZWQgYmVmb3JlIFBGLgorCSAqIFNvIHdlIG5lZWQgdG8gc3RvcCBWRiBkcml2ZXIgYXQgZmlyc3Qs
IHRoYXQgbWVhbnMKKwkgKiBsb29wIHJldmVyc2VseSwgYW5kIGxhdGVyIGR1cmluZyBzdG9wIFBG
IGRyaXZlciwKKwkgKiBkaXNhYmxlX3NyaW92IHdpbGwgdXNlIHZpcnRmbl9yZW1vdmUgdG8gcmVt
b3ZlIFZGcy4KKwkgKgogCSAqIFN0b3BwaW5nIGFuIFNSLUlPViBQRiBkZXZpY2UgcmVtb3ZlcyBh
bGwgdGhlIGFzc29jaWF0ZWQgVkZzLAogCSAqIHdoaWNoIHdpbGwgdXBkYXRlIHRoZSBidXMtPmRl
dmljZXMgbGlzdCBhbmQgY29uZnVzZSB0aGUKIAkgKiBpdGVyYXRvci4gIFRoZXJlZm9yZSwgaXRl
cmF0ZSBpbiByZXZlcnNlIHNvIHdlIHJlbW92ZSB0aGUgVkZzCkBAIC0xMTYsOCArMTIzLDcgQEAg
aW50IHBjaWVocF91bmNvbmZpZ3VyZV9kZXZpY2Uoc3RydWN0IHNsbwogCSAqLwogCWxpc3RfZm9y
X2VhY2hfZW50cnlfc2FmZV9yZXZlcnNlKGRldiwgdGVtcCwgJnBhcmVudC0+ZGV2aWNlcywKIAkJ
CQkJIGJ1c19saXN0KSB7Ci0JCXBjaV9kZXZfZ2V0KGRldik7Ci0JCXBjaV9zdG9wX2FuZF9yZW1v
dmVfYnVzX2RldmljZShkZXYpOworCQlwY2lfc3RvcF9idXNfZGV2aWNlKGRldik7CiAJCS8qCiAJ
CSAqIEVuc3VyZSB0aGF0IG5vIG5ldyBSZXF1ZXN0cyB3aWxsIGJlIGdlbmVyYXRlZCBmcm9tCiAJ
CSAqIHRoZSBkZXZpY2UuCkBAIC0xMjgsNiArMTM0LDExIEBAIGludCBwY2llaHBfdW5jb25maWd1
cmVfZGV2aWNlKHN0cnVjdCBzbG8KIAkJCWNvbW1hbmQgfD0gUENJX0NPTU1BTkRfSU5UWF9ESVNB
QkxFOwogCQkJcGNpX3dyaXRlX2NvbmZpZ193b3JkKGRldiwgUENJX0NPTU1BTkQsIGNvbW1hbmQp
OwogCQl9CisJfQorCisJbGlzdF9mb3JfZWFjaF9lbnRyeV9zYWZlKGRldiwgdGVtcCwgJnBhcmVu
dC0+ZGV2aWNlcywgYnVzX2xpc3QpIHsKKwkJcGNpX2Rldl9nZXQoZGV2KTsKKwkJcGNpX3JlbW92
ZV9idXNfZGV2aWNlKGRldik7CiAJCXBjaV9kZXZfcHV0KGRldik7CiAJfQogCkluZGV4OiBsaW51
eC0yLjYvZHJpdmVycy9wY2kvcmVtb3ZlLmMKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQotLS0gbGludXgtMi42Lm9yaWcv
ZHJpdmVycy9wY2kvcmVtb3ZlLmMKKysrIGxpbnV4LTIuNi9kcml2ZXJzL3BjaS9yZW1vdmUuYwpA
QCAtNTYsNyArNTYsNyBAQCB2b2lkIHBjaV9yZW1vdmVfYnVzKHN0cnVjdCBwY2lfYnVzICpidXMp
CiB9CiBFWFBPUlRfU1lNQk9MKHBjaV9yZW1vdmVfYnVzKTsKIAotc3RhdGljIHZvaWQgcGNpX3N0
b3BfYnVzX2RldmljZShzdHJ1Y3QgcGNpX2RldiAqZGV2KQordm9pZCBwY2lfc3RvcF9idXNfZGV2
aWNlKHN0cnVjdCBwY2lfZGV2ICpkZXYpCiB7CiAJc3RydWN0IHBjaV9idXMgKmJ1cyA9IGRldi0+
c3Vib3JkaW5hdGU7CiAJc3RydWN0IHBjaV9kZXYgKmNoaWxkLCAqdG1wOwpAQCAtNzYsNyArNzYs
NyBAQCBzdGF0aWMgdm9pZCBwY2lfc3RvcF9idXNfZGV2aWNlKHN0cnVjdCBwCiAJcGNpX3N0b3Bf
ZGV2KGRldik7CiB9CiAKLXN0YXRpYyB2b2lkIHBjaV9yZW1vdmVfYnVzX2RldmljZShzdHJ1Y3Qg
cGNpX2RldiAqZGV2KQordm9pZCBwY2lfcmVtb3ZlX2J1c19kZXZpY2Uoc3RydWN0IHBjaV9kZXYg
KmRldikKIHsKIAlzdHJ1Y3QgcGNpX2J1cyAqYnVzID0gZGV2LT5zdWJvcmRpbmF0ZTsKIAlzdHJ1
Y3QgcGNpX2RldiAqY2hpbGQsICp0bXA7CkluZGV4OiBsaW51eC0yLjYvZHJpdmVycy9wY2kvcGNp
LmgKPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PQotLS0gbGludXgtMi42Lm9yaWcvZHJpdmVycy9wY2kvcGNpLmgKKysrIGxp
bnV4LTIuNi9kcml2ZXJzL3BjaS9wY2kuaApAQCAtMzE3LDQgKzMxNyw3IEBAIHN0YXRpYyBpbmxp
bmUgaW50IHBjaV9kZXZfc3BlY2lmaWNfcmVzZXQKIH0KICNlbmRpZgogCit2b2lkIHBjaV9zdG9w
X2J1c19kZXZpY2Uoc3RydWN0IHBjaV9kZXYgKmRldik7Cit2b2lkIHBjaV9yZW1vdmVfYnVzX2Rl
dmljZShzdHJ1Y3QgcGNpX2RldiAqZGV2KTsKKwogI2VuZGlmIC8qIERSSVZFUlNfUENJX0ggKi8K
--047d7bdc1c3e11385e04e235f957
Content-Type: application/octet-stream; name="fix_cx3_hotplug_2.patch"
Content-Disposition: attachment; filename="fix_cx3_hotplug_2.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hjhq0kx42

U3ViamVjdDogW1BBVENIXSBQQ0k6IFN0b3Agc3Jpb3YgYWZ0ZXIgc3RvcCBQRiBpZiBQRidzIGRy
aXZlciBza2lwIHRoYXQKRnJvbTogWWluZ2hhaSBMdSA8eWluZ2hhaUBrZXJuZWwub3JnPgoKQWZ0
ZXIgY29tbWl0IGRjMDg3ZjJmNmEyOTI1ZTgxODMxZjMwMTZiOWNiYjZlNDcwZTc0MjMKKFBDSTog
U2ltcGxpZnkgSU9WIGltcGxlbWVudGF0aW9uIGFuZCBmaXggcmVmZXJlbmNlIGNvdW50IHJhY2Vz
KQpWRiBuZWVkIHRvIGJlIHJlbW92ZWQgdmlhIHZpcnRmbl9yZW1vdmUgdG8gbWFrZSBzdXJlIHJl
ZiB0byBQRgppcyBwdXQgYmFjay4KClNvbWUgZHJpdmVyIChsaWtlIGl4Z2JlKSBkb2VzIG5vdCBj
YWxsIHBjaV9kaXNhYmxlX3NyaW92KCkgaWYKc3Jpb3YgaXMgZW5hYmxlZCB2aWEgL3N5cy8uLi4v
c3Jpb3ZfbnVtdmZzIHNldHRpbmcuCml4Z2JlIGRvZXMgYWxsb3cgZHJpdmVyIGZvciBQRiBnZXQg
ZGV0YWNoZWQsIGJ1dCBzdGlsbCBoYXZlIFZGcwphcm91bmQuCgpCdXQgaG93IGFib3V0IFBGIGdl
dCByZW1vdmVkIHZpYSAvc3lzIG9yIHBjaWVocCBmaW5hbGx5PwoKRHVyaW5nIGhvdC1yZW1vdmUs
IFZGIHdpbGwgc3RpbGwgaG9sZCBvbmUgcmVmIHRvIFBGIGFuZCBpdApwcmV2ZW50IFBGIHRvIGJl
IHJlbW92ZWQuClRoYXQgbWFrZSB0aGUgbmV4dCBob3QtYWRkIGZhaWxzLCBhcyBvbGQgUEYgZGV2
IHN0cnVjdCBpcyBzdGlsbCBhcm91bmQuCgpXZSBuZWVkIHRvIGFkZCBwY2lfZGlzYWJsZV9zcmlv
digpIGNhbGxpbmcgZHVyaW5nIHN0b3AgUEYgLgoKTmVlZCB0aGlzIG9uZSBmb3IgdjMuMTEKCi12
MjogQWNjb3JpbmcgdG8gQmpvcm4sIG1vdmUgdGhhdCBjYWxsaW5nIHRvIHBjaV9zdG9wX2Rldi4K
ClNpZ25lZC1vZmYtYnk6IFlpbmdoYWkgTHUgPHlpbmdoYWlAa2VybmVsLm9yZz4KQ2M6IEppYW5n
IExpdSA8bGl1ajk3QGdtYWlsLmNvbT4KQ2M6IEFsZXhhbmRlciBEdXljayA8YWxleGFuZGVyLmgu
ZHV5Y2tAaW50ZWwuY29tPgpDYzogRG9uYWxkIER1dGlsZSA8ZGR1dGlsZUByZWRoYXQuY29tPgpD
YzogR3JlZyBSb3NlIDxncmVnb3J5LnYucm9zZUBpbnRlbC5jb20+CgotLS0KIGRyaXZlcnMvcGNp
L3JlbW92ZS5jIHwgICAgMiArKwogMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKSW5k
ZXg6IGxpbnV4LTIuNi9kcml2ZXJzL3BjaS9yZW1vdmUuYwo9PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Ci0tLSBsaW51eC0y
LjYub3JpZy9kcml2ZXJzL3BjaS9yZW1vdmUuYworKysgbGludXgtMi42L2RyaXZlcnMvcGNpL3Jl
bW92ZS5jCkBAIC0yNSw2ICsyNSw4IEBAIHN0YXRpYyB2b2lkIHBjaV9zdG9wX2RldihzdHJ1Y3Qg
cGNpX2RldgogCQlwY2lfcHJvY19kZXRhY2hfZGV2aWNlKGRldik7CiAJCXBjaV9yZW1vdmVfc3lz
ZnNfZGV2X2ZpbGVzKGRldik7CiAJCWRldmljZV9kZWwoJmRldi0+ZGV2KTsKKwkJLyogcmVtb3Zl
IFZGLCBpZiBQRiBkcml2ZXIgc2tpcCB0aGF0ICovCisJCXBjaV9kaXNhYmxlX3NyaW92KGRldik7
CiAJCWRldi0+aXNfYWRkZWQgPSAwOwogCX0KIAo=
--047d7bdc1c3e11385e04e235f957--
