Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:32955 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932846Ab3BSXJD (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 19 Feb 2013 18:09:03 -0500
Received: by mail-oa0-f41.google.com with SMTP id i10so7596263oag.0
        for <linux-pci@vger.kernel.org>; Tue, 19 Feb 2013 15:09:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5122A19B.9090308@nber.org>
References: <5122A19B.9090308@nber.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 19 Feb 2013 16:08:43 -0700
Message-ID: <CAErSpo6KhkE2Z1smhqv3vct+B7z=21N4DVmzVdS=E6v-N=BxJQ@mail.gmail.com>
Subject: Re: Problem with MSI with QLogic/HP 10Gigabit Ethernet NIC and IRQs
 solved with pci=nomsi
To: Alex Aminoff <aminoff@nber.org>
Cc: linux-pci@vger.kernel.org, Daniel Feenberg <feenberg@nber.org>,
	Mohan Ramanujan <mohan@nber.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Mon, Feb 18, 2013 at 2:48 PM, Alex Aminoff <aminoff@nber.org> wrote:
>
> As recommended in the MSI-HOWTO, we are submitting our case where we believe
> that certain hardware does not work correctly with MSI.

Thanks for your report!

> We have two machines running Scientific Linux:
>
> Linux age9 2.6.32-279.19.1.el6.x86_64 #1 SMP Tue Dec 18 17:22:54 CST 2012
> x86_64 x86_64 x86_64 GNU/Linux

As I'm sure you know, this is a pretty old kernel, and any fixes to it
would be made by your vendor.

Is it possible for you to test a current kernel, e.g., v3.8?  The bug
may have been fixed between 2.6.32 and 3.8.  If not, I'd definitely
like to fix it in the upstream kernel so v3.9 would work out of the
box.  If you could collect complete dmesg logs from v3.8 both with and
without "pci=nomsi", that would be very helpful.

> The symptom appeared to be problems with the 10G ethernet card that produced
> error messages about do_IRQ. (It so happens that these machines boot
> diskless so NFS problems would crash or hang the machines; therefore others
> with the same setup but booting from local disk might not experience this to
> the same severity).
>
> The problems appear to be gone now that we are booting with pci=nomsi.

Bjorn
