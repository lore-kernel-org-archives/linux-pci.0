Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:37890 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757683Ab2IGWf7 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 7 Sep 2012 18:35:59 -0400
Received: by eekc1 with SMTP id c1so40015eek.19
        for <linux-pci@vger.kernel.org>; Fri, 07 Sep 2012 15:35:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAE9FiQXO3R8oQH2rNky64SWe-4DRx7HJr3-rp0eqEZvQbN4W2A@mail.gmail.com>
References: <bug-18412-41252@https.bugzilla.kernel.org/>
	<20120907214005.5077211FC43@bugzilla.kernel.org>
	<CAErSpo6vMjr=veZs8AWg1X5EfWfGNeUFkz1EExF4+km9fnOwmQ@mail.gmail.com>
	<CAE9FiQXO3R8oQH2rNky64SWe-4DRx7HJr3-rp0eqEZvQbN4W2A@mail.gmail.com>
Date: Fri, 7 Sep 2012 15:35:57 -0700
Message-ID: <CAE9FiQWaY_RzxRtSfNi-u9rBW0SOVzTeXnOvc6NAbLPyzYigxA@mail.gmail.com>
Subject: Re: [Bug 18412] Intel DP43BF requires "pci=assign-busses" to discover
 some devices
From: Yinghai Lu <yinghai@kernel.org>
To: Bjorn Helgaas <bhelgaas@google.com>, vl.homutov@gmail.com
Cc: bugzilla-daemon@bugzilla.kernel.org, linux-pci@vger.kernel.org
Content-Type: multipart/mixed; boundary=000e0cdfcbcc4b078804c9243b9d
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

--000e0cdfcbcc4b078804c9243b9d
Content-Type: text/plain; charset=ISO-8859-1

On Fri, Sep 7, 2012 at 3:15 PM, Yinghai Lu <yinghai@kernel.org> wrote:
> On Fri, Sep 7, 2012 at 2:52 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
>> On Fri, Sep 7, 2012 at 2:40 PM,  <bugzilla-daemon@bugzilla.kernel.org> wrote:
>>> https://bugzilla.kernel.org/show_bug.cgi?id=18412
>>
>>> --- Comment #4 from VL <vl.homutov@gmail.com>  2012-09-07 21:40:04 ---
>>> The bug is still there with behaviour exactly as specified by reporter.
>>>
>>> Tested with linux-3.4.9 (gentoo), DP43BF motherboard and Intel PRO/1000 NICs.
>>> With pci=assign-busses lspci shows devices properly, without it nothing
>>> is in the list.
>
> VL,
>
> I rebased for-pci-busn-alloc branch to current pci-next
>
> please check if could fix the problem.
>
> git://git.kernel.org/pub/scm/linux/kernel/git/yinghai/linux-yinghai.git
> for-pci-busn-alloc
>
> http://git.kernel.org/?p=linux/kernel/git/yinghai/linux-yinghai.git;a=shortlog;h=refs/heads/for-pci-busn-alloc
>

also you could try attached patch

Thanks

Yinghai

--000e0cdfcbcc4b078804c9243b9d
Content-Type: application/octet-stream;
	name="pci_bridge_more_bus_check.patch"
Content-Disposition: attachment; filename="pci_bridge_more_bus_check.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_h6tv68re0

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3Byb2JlLmMgYi9kcml2ZXJzL3BjaS9wcm9iZS5jCmlu
ZGV4IDNjZGJhOGIuLjBmYzI3MDMgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvcGNpL3Byb2JlLmMKKysr
IGIvZHJpdmVycy9wY2kvcHJvYmUuYwpAQCAtNzI5LDcgKzcyOSw4IEBAIGludCBfX2RldmluaXQg
cGNpX3NjYW5fYnJpZGdlKHN0cnVjdCBwY2lfYnVzICpidXMsIHN0cnVjdCBwY2lfZGV2ICpkZXYs
IGludCBtYXgsCiAKIAkvKiBDaGVjayBpZiBzZXR1cCBpcyBzZW5zaWJsZSBhdCBhbGwgKi8KIAlp
ZiAoIXBhc3MgJiYKLQkgICAgKHByaW1hcnkgIT0gYnVzLT5udW1iZXIgfHwgc2Vjb25kYXJ5IDw9
IGJ1cy0+bnVtYmVyKSkgeworCSAgICAocHJpbWFyeSAhPSBidXMtPm51bWJlciB8fCBzZWNvbmRh
cnkgPD0gYnVzLT5udW1iZXIgfHwKKwkgICAgIHNlY29uZGFyeSA+IHN1Ym9yZGluYXRlICkpIHsK
IAkJZGV2X2RiZygmZGV2LT5kZXYsICJidXMgY29uZmlndXJhdGlvbiBpbnZhbGlkLCByZWNvbmZp
Z3VyaW5nXG4iKTsKIAkJYnJva2VuID0gMTsKIAl9Cg==
--000e0cdfcbcc4b078804c9243b9d--
