Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-qc0-f172.google.com ([209.85.216.172]:45398 "EHLO
	mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750764AbbBYFqk (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 25 Feb 2015 00:46:40 -0500
Received: by qcvp6 with SMTP id p6so1315078qcv.12
        for <linux-pci@vger.kernel.org>; Tue, 24 Feb 2015 21:46:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAPM=9tz8HQAZbdfgE15++i++NkArjxqiY3-BjANqDBTo1g-pOw@mail.gmail.com>
References: <CAPM=9tz8HQAZbdfgE15++i++NkArjxqiY3-BjANqDBTo1g-pOw@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 24 Feb 2015 23:46:19 -0600
Message-ID: <CAErSpo5+S58_3sRBDXmgKZ5Ms_dC-q3rEsdYZX9aXt+h9AJjsg@mail.gmail.com>
Subject: Re: regression in 4.0.0-rc1 with r8169 ethernet
To: Dave Airlie <airlied@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

[+cc linux-pci]

On Tue, Feb 24, 2015 at 9:47 PM, Dave Airlie <airlied@gmail.com> wrote:
> Hey,
>
> just booted an old AMD rs780 box with new kernel and my ethernet
> failed to come up!
>
> Looks like the MAC addr is all ff's because the PCI bridge windows are
> messed up.
>
> I've attached two dmesg one from a 3.19.0-rc6 I had on it, and one
> failing from the 4.0.0-rc1 time.
>
> b24e2bdde4af656bb0679a101265ebb8f8735d3c is latest Linus commit in
> that tree (I have some radeon patches on top).
>
> motherboard is a Gigabyte GA-MA78GM-S2H, lspci also attached.

Hi Dave,

Looking, thanks for the report and sorry for the inconvenience.

Bjorn
