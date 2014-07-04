Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <53B5F81B.8010801@freescale.com>
Date: Fri, 4 Jul 2014 06:10:59 +0530
From: Prabhakar Kushwaha <prabhakar@freescale.com>
MIME-Version: 1.0
To: Tanmay Inamdar <tinamdar@apm.com>,
	<linux-arm-kernel@lists.infradead.org>,
	<linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <liviu.dudau@arm.com>, <galak@codeaurora.org>
Subject: Re: [PATCH] arm64: PCI(e) arch support
References: <1404422876-1160-1-git-send-email-tinamdar@apm.com>
In-Reply-To: <1404422876-1160-1-git-send-email-tinamdar@apm.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Tanmay, Liviu,
On 7/4/2014 2:57 AM, Tanmay Inamdar wrote:
> Reposting on request of several people since previously posted one was
> corrupted.
>
> This patch adds the arch support for PCI(e) for arm64. The files
> added or modified in this patch are based on PCI(e) support in
> 32bit arm.
>
> Please note that this patch is just for the reference. Liviu Dudau from ARM
> has posted his v8 series of patch to support PCIe in arm64.
>
> The patch will apply against 3.13 Linux Kernel
>
> Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
>

do we foresee similar type of changes in u-boot  to support PCI(e) for 
ARM64.

Regards,
Prabhakar


