Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ie0-f179.google.com ([209.85.223.179]:40312 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752091Ab3B0GrK (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Feb 2013 01:47:10 -0500
Received: by mail-ie0-f179.google.com with SMTP id k11so230611iea.24
        for <linux-pci@vger.kernel.org>; Tue, 26 Feb 2013 22:47:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <512DAAC9.8030400@cn.fujitsu.com>
References: <alpine.DEB.2.02.1301181302260.31163@jlaw-desktop.mno.stratus.com>
	<alpine.DEB.2.02.1301181322500.31163@jlaw-desktop.mno.stratus.com>
	<51122BED.8090308@cn.fujitsu.com>
	<CAErSpo6aGiuBbgcVfcduPk++7B_zzuk2Y+fjLiJBvdOqnU+Qmw@mail.gmail.com>
	<5122F276.80807@cn.fujitsu.com>
	<CAErSpo7BeCiKHecJgX9GBR7DYf4M9mrXK+qMLMDXFykxq5C7sQ@mail.gmail.com>
	<512AFDB7.5030105@cn.fujitsu.com>
	<CAL-B5D0xN6bs3oXugS9FOS5bQiFRJQ9766u5wsXw4UQdUmwfyw@mail.gmail.com>
	<512DAAC9.8030400@cn.fujitsu.com>
Date: Tue, 26 Feb 2013 22:47:09 -0800
Message-ID: <CAE9FiQU6Sj=wkare0VCJwP1Yr09o=xVMrhsY_xJ1_41=YMkwMg@mail.gmail.com>
Subject: Re: [PATCH 1/2] PCI: ASPM exit link state code could skip devices
From: Yinghai Lu <yinghai@kernel.org>
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: Myron Stowe <myron.stowe@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Joe Lawrence <Joe.Lawrence@stratus.com>,
	linux-pci@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>,
	Myron Stowe <mstowe@redhat.com>,
	David Bulkow <david.bulkow@stratus.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Feb 26, 2013 at 10:42 PM, Gu Zheng <guz.fnst@cn.fujitsu.com> wrote:
>     I just agree with Bjorn's analysis. And I have test Yinghai's patch on kernel 3.8
> , but it seems does not work. More infos, please refer to bugzilla:
> https://bugzilla.kernel.org/show_bug.cgi?id=54411

you need to test that on linus's tree of 2013-02-26.
or v3.9-rc1

Thanks

Yinghai
