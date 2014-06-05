Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:65389 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbaFELqI (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jun 2014 07:46:08 -0400
Received: by mail-lb0-f173.google.com with SMTP id 10so490950lbg.18
        for <linux-pci@vger.kernel.org>; Thu, 05 Jun 2014 04:46:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <22265253.jvFXIxhohU@vostro.rjw.lan>
References: <CA+eFSM2CBiWZNmpnSNGKZGjEpK6gc=T0a5r7m6sbORi==XTCjQ@mail.gmail.com>
	<CA+eFSM3683deo8aRiKo6Yobq6sRoWgyoVV+gCnTHaSUNjYcHaA@mail.gmail.com>
	<CAErSpo60LfyX=qmui=kTsg851jgu_DU-RCXZr-MgVA3CfFThRA@mail.gmail.com>
	<22265253.jvFXIxhohU@vostro.rjw.lan>
Date: Thu, 5 Jun 2014 19:46:06 +0800
Message-ID: <CA+eFSM0Cnij7EEUZhWNsyrERquUiOE4Jt8d_Ra=bt5VZZtLDwA@mail.gmail.com>
Subject: Re: PCI-to-USB ExpressCard Hotplugging can't work in v3.15-rc5
From: Gavin Guo <gavin.guo@canonical.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Bjorn Helgaas <bhelgaas@google.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Yinghai Lu <yinghai@kernel.org>, YK <yk@canonical.com>,
	Yung Shen <yung.shen@canonical.com>,
	Po-Hsu Lin <po-hsu.lin@canonical.com>,
	Jiang Liu <jiang.liu@linux.intel.com>
Content-Type: multipart/mixed; boundary=089e011770cb56a25104fb154af2
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--089e011770cb56a25104fb154af2
Content-Type: text/plain; charset=UTF-8

On Thu, May 22, 2014 at 7:36 AM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> On Wednesday, May 21, 2014 07:53:37 AM Bjorn Helgaas wrote:
>> On Wed, May 21, 2014 at 3:45 AM, Gavin Guo <gavin.guo@canonical.com> wrote:
>> > Hi Bjorn,
>> >
>> > On Wed, May 21, 2014 at 12:54 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> >> On Tue, May 20, 2014 at 10:36 PM, Gavin Guo <gavin.guo@canonical.com> wrote:
>> >>> Hi all,
>> >>>
>> >>> I have a APIOTEK PCI-to-USB ExpressCard and found that when it is
>> >>> plugged at cold boot, the card can be detected. But, hotplug cannot
>> >>> work at run time. The bug may be related to the commit which I
>> >>> reported last year:
>> >>>
>> >>> commit 3f327e39b4b8f760c331bb2836735be6d83fbf53
>> >>
>> >> Where is your report from last year?  How did you identify this
>> >> commit?  Did you verify that it works correctly with v3.10-rc1, but
>> >> fails when you add this commit?
>> >
>> > The mail about the bug I reported last year is attached. And I'm sorry
>> > about not describing clearly. This commit is the one to fix the bug
>> > before. So, I think it will be a clue to find out what's wrong. I've
>> > built v3.10 and tested it on the platform. It works fine. The bug
>> > seems like a regression.
>> >
>> > I also attached the dmesg of v3.10 which works correctly with hotplug.
>>
>> v3.10 contains 3f327e39b4b8 (it appeared in v3.10-rc3).  So since it
>> works correctly in v3.10, that commit is probably not the cause of the
>> regression.
>>
>> So apparently it worked in v3.10 and broke sometime later.  Do you
>> know when it broke?
>>
>> We're getting Bus Check events:
>>
>>   ACPI: \_SB_.PCI0: ACPI_NOTIFY_BUS_CHECK event
>>
>> but apparently we aren't handling them correctly.  Can you turn on the
>> debug in the acpi_hotplug_schedule() path and add more if necessary to
>> if we get to acpi_hotplug_work_fn(), acpi_device_hotplug(), etc.?  I'm
>> not familiar with that path, so either you'll have to narrow it down,
>> or we can hope that Yinghai or Rafael has some insight.
>
> Well, it would be good to create a bug entry for this at bugzilla.kernel.org
> against ACPI/Config-hotplug and mark it as a regression.

I've completed the bisect and found
2d8b1d566a5f4874f4d92361f5cdbb50baa396f8 is the first bad commit. The
"git bisect log" is also attached.

commit 2d8b1d566a5f4874f4d92361f5cdbb50baa396f8
Author: Mika Westerberg <mika.westerberg@linux.intel.com>
Date: Sat Jul 13 20:09:59 2013 +0300

    ACPI / hotplug / PCI: Get rid of check_sub_bridges()

    Now that acpiphp_check_bridge() always enumerates devices behind the
    bridge, there is no need to do that for each sub-bridge anymore like
    it is done in the current ACPI-based PCI hotplug (ACPIPHP) code.

    Given this we don't need check_sub_bridges() anymore, so drop that
    function completely.

    This also simplifies the ACPIPHP code a bit.

    Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

:040000 040000 1f3f81404e06c92c01d6848ed7a6c5bffdb5f878
4e7ca3e4af42738f90555640cafbb6e6522ceedf M drivers

>
> Rafael
>
>
>> >>> Author: Yinghai Lu <yinghai@kernel.org>
>> >>> Date:   Tue May 7 11:06:03 2013 -0600
>> >>>
>> >>>     PCI: acpiphp: Re-enumerate devices when host bridge receives Bus Check
>> >>>
>> >>>     When a PCI host bridge device receives a Bus Check notification, we
>> >>>     must re-enumerate starting with the bridge to discover changes (devices
>> >>>     that have been added or removed).
>> >>>
>> >>>     Prior to 668192b678 ("PCI: acpiphp: Move host bridge hotplug to
>> >>>     pci_root.c"), this happened in _handle_hotplug_event_bridge().  After that
>> >>>     commit, _handle_hotplug_event_bridge() is not installed for host bridges,
>> >>>     and the host bridge notify handler, _handle_hotplug_event_root() did not
>> >>>     re-enumerate.
>> >>>
>> >>>     This patch adds re-enumeration to _handle_hotplug_event_root().
>> >>>
>> >>>     This fixes cases where we don't notice the addition or removal of
>> >>>     PCI devices, e.g., the PCI-to-USB ExpressCard in the bugzilla below.
>> >>>
>> >>> Dmesg is attached. The scenario of the dmesg: The PCI-to-USB
>> >>> ExpressCard is attached at cold boot. Then, you can see that the usb
>> >>> storage can be detected in the dmesg. Finally, I've done hotplug 2
>> >>> times to see if it can detect the PCI-to-USB ExpressCard. At the end
>> >>> of Dmesg, it only has several "ACPI: \_SB_.PCI0: ACPI_NOTIFY_BUS_CHECK
>> >>> event" and can't detect the card.
>> >>>
>> >>> Thanks,
>> >>> Gavin Guo
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
> --
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.

--089e011770cb56a25104fb154af2
Content-Type: text/x-log; charset=US-ASCII; name="bisect_acpiphp.log"
Content-Disposition: attachment; filename="bisect_acpiphp.log"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hw1zygnv0

IyBiYWQ6IFsyNzJiOThjNjQ1NWYwMDg4NGYwMzUwZjc3NWM1MzQyMzU4ZWJiNzNmXSBMaW51eCAz
LjEyLXJjMQojIGdvb2Q6IFs2ZTQ2NjQ1MjViMWRiMjhmOGM0ZTExMzA5NTdmNzBhOTRjMTkyMTNl
XSBMaW51eCAzLjExCiMgZ29vZDogWzM5NzcyMDM4ZWE5M2U4NWVhNGYxMzA3ZWM5YzFmNDhhMDYz
ZDg5YTBdIFBDSTogQXNzaWduIHJlc291cmNlcyBmb3IgaG90LWFkZGVkIGhvc3QgYnJpZGdlIG1v
cmUgYWdncmVzc2l2ZWx5CiMgZ29vZDogWzNkYzQ4YWYzMTA3MDliODVkMDdjOGIwZDNhYThmMWVh
ZDAyODI5ZDNdIFBDSS9BQ1BJOiBGaXggX09TQyBvcmRlcmluZyB0byBhbGxvdyBQQ0llIGhvdHBs
dWcgdXNlIHdoZW4gYXZhaWxhYmxlCmdpdCBiaXNlY3Qgc3RhcnQgJ3YzLjEyLXJjMScgJ3YzLjEx
JyAnMzk3NzIwMzhlYTkzZTg1ZWE0ZjEzMDdlYzljMWY0OGEwNjNkODlhMCcgJzNkYzQ4YWYzMTA3
MDliODVkMDdjOGIwZDNhYThmMWVhZDAyODI5ZDMnICctLScKIyBiYWQ6IFs1N2Q3MzA5MjRkNWNj
MmMzZTI4MGFmMTZhOTMwNjU4N2MzYTUxMWRiXSBNZXJnZSBicmFuY2ggJ3RpbWVycy11cmdlbnQt
Zm9yLWxpbnVzJyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvdGlwL3RpcApnaXQgYmlzZWN0IGJhZCA1N2Q3MzA5MjRkNWNjMmMzZTI4MGFmMTZhOTMwNjU4
N2MzYTUxMWRiCiMgYmFkOiBbMzU3Mzk3YTE0MTE3ZjBjMmVlYWZjYWMwNmExZjg0MTJhMDJhYTZh
Zl0gTWVyZ2UgYnJhbmNoICdmb3ItMy4xMicgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L3RqL2xpYmF0YQpnaXQgYmlzZWN0IGJhZCAzNTczOTdhMTQxMTdm
MGMyZWVhZmNhYzA2YTFmODQxMmEwMmFhNmFmCiMgZ29vZDogWzkxMTIxYzEwM2FlOTNlZjExN2U1
ODcxMjc4Njg2NDI3MGQ3ZjQ4OGVdIHN0YWdpbmc6IGR3YzI6IG1ha2UgZHdjMl9jb3JlX3BhcmFt
cyBkb2N1bWVudGF0aW9uIG1vcmUgY29tcGxldGUKZ2l0IGJpc2VjdCBnb29kIDkxMTIxYzEwM2Fl
OTNlZjExN2U1ODcxMjc4Njg2NDI3MGQ3ZjQ4OGUKIyBnb29kOiBbMWQxZmRkOTVkZjY4MWYwYzA2
NWQ5MGZmYWFmYTIxNWEwZTg4MjVlMl0gTWVyZ2UgdGFnICdjaGFyLW1pc2MtMy4xMi1yYzEnIG9m
IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9ncmVna2gvY2hh
ci1taXNjCmdpdCBiaXNlY3QgZ29vZCAxZDFmZGQ5NWRmNjgxZjBjMDY1ZDkwZmZhYWZhMjE1YTBl
ODgyNWUyCiMgZ29vZDogW2Q0NzJkOWQ5OGI0NjNkZDdhMDRmMmJjZGVhZmU0MjYxNjg2Y2U2YWJd
IGxvY2tyZWY6IFJlbGF4IGluIGNtcHhjaGcgbG9vcApnaXQgYmlzZWN0IGdvb2QgZDQ3MmQ5ZDk4
YjQ2M2RkN2EwNGYyYmNkZWFmZTQyNjE2ODZjZTZhYgojIGJhZDogWzdhMzMwYTU0MTZkZTkyNDBj
OTNhNjk4N2UxMWNiMzJiNTgxZDMyNjNdIE1lcmdlIGJyYW5jaCAncG0tY3B1ZnJlcScKZ2l0IGJp
c2VjdCBiYWQgN2EzMzBhNTQxNmRlOTI0MGM5M2E2OTg3ZTExY2IzMmI1ODFkMzI2MwojIGJhZDog
Wzg0NjJkOWRmOWQ1MDMzZGE0ZDI1ZTU5MDE2YjFlN2E5ZDk0YTFmMjJdIE1lcmdlIGJyYW5jaCAn
YWNwaS1iaW5kJwpnaXQgYmlzZWN0IGJhZCA4NDYyZDlkZjlkNTAzM2RhNGQyNWU1OTAxNmIxZTdh
OWQ5NGExZjIyCiMgYmFkOiBbYWJlNTQzMGU5ZDUzMTQxOTBjYTU3MWIzYmZjMGM0MjAwMDYzNDM3
OF0gTWVyZ2UgYnJhbmNoICdhY3BpLXBjaS1ob3RwbHVnJwpnaXQgYmlzZWN0IGJhZCBhYmU1NDMw
ZTlkNTMxNDE5MGNhNTcxYjNiZmMwYzQyMDAwNjM0Mzc4CiMgZ29vZDogW2M4ZWJjZjFmZjkxYThm
NjRiMDljNGRmMGVlMjFhZTgwYTk1M2MzOWNdIEFDUEkgLyBob3RwbHVnIC8gUENJOiBQYXNzIGhv
dHBsdWcgY29udGV4dCBvYmplY3RzIHRvIGV2ZW50IGhhbmRsZXJzCmdpdCBiaXNlY3QgZ29vZCBj
OGViY2YxZmY5MWE4ZjY0YjA5YzRkZjBlZTIxYWU4MGE5NTNjMzljCiMgZ29vZDogWzVjOGQwZTFk
YzQ3NWYwZjM1YjVhNzc0YzkyYzY4YzNmN2RiZDNmNWZdIEFDUEkgLyBob3RwbHVnIC8gUENJOiBE
byBub3QgcXVldWUgdXAgZXZlbnQgaGFuZGxpbmcgd29yayBpdGVtcyBpbiB2YWluCmdpdCBiaXNl
Y3QgZ29vZCA1YzhkMGUxZGM0NzVmMGYzNWI1YTc3NGM5MmM2OGMzZjdkYmQzZjVmCiMgZ29vZDog
W2ExZDBhYmNlYTg0NTczMGM0ZmYyZjQ3ODk3ZTI4YzJmMTFjNzlkNGZdIEFDUEkgLyBob3RwbHVn
IC8gUENJOiBSZWRlZmluZSBlbmFibGVfZGV2aWNlKCkgYW5kIGRpc2FibGVfZGV2aWNlKCkKZ2l0
IGJpc2VjdCBnb29kIGExZDBhYmNlYTg0NTczMGM0ZmYyZjQ3ODk3ZTI4YzJmMTFjNzlkNGYKIyBi
YWQ6IFsxYWFhYzA3MTEyZjA0MDY4ZDdlMmZjNDdiYjQzNWNmZDRmOWQ1NDY4XSBBQ1BJIC8gaG90
cGx1ZyAvIFBDSTogRml4IE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSBpbiBjbGVhbnVwX2JyaWRn
ZSgpCmdpdCBiaXNlY3QgYmFkIDFhYWFjMDcxMTJmMDQwNjhkN2UyZmM0N2JiNDM1Y2ZkNGY5ZDU0
NjgKIyBiYWQ6IFsyZDhiMWQ1NjZhNWY0ODc0ZjRkOTIzNjFmNWNkYmI1MGJhYTM5NmY4XSBBQ1BJ
IC8gaG90cGx1ZyAvIFBDSTogR2V0IHJpZCBvZiBjaGVja19zdWJfYnJpZGdlcygpCmdpdCBiaXNl
Y3QgYmFkIDJkOGIxZDU2NmE1ZjQ4NzRmNGQ5MjM2MWY1Y2RiYjUwYmFhMzk2ZjgKIyBnb29kOiBb
ZmYxODFlNWE0ZjZiNTM2ZTVmM2YxNjAxY2Q1YzU0ZTc5MmNkOWFiY10gQUNQSSAvIGhvdHBsdWcg
LyBQQ0k6IENsZWFuIHVwIGJyaWRnZV9tdXRleCB1c2FnZQpnaXQgYmlzZWN0IGdvb2QgZmYxODFl
NWE0ZjZiNTM2ZTVmM2YxNjAxY2Q1YzU0ZTc5MmNkOWFiYwo=
--089e011770cb56a25104fb154af2--
