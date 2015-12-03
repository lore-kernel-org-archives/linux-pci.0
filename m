Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:33309 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbbLCKsa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 3 Dec 2015 05:48:30 -0500
MIME-Version: 1.0
In-Reply-To: <1449136489-2559-1-git-send-email-lftan@altera.com>
References: <1449136489-2559-1-git-send-email-lftan@altera.com>
Date: Thu, 3 Dec 2015 18:48:29 +0800
Message-ID: <CAFiDJ5_5wifd+Xjmcub9UbMSdgbZ2SKgz9f+Ltb2Wi6JF5=PGA@mail.gmail.com>
Subject: Re: [PATCH 0/3] fixes to support multi-functions device
From: Ley Foon Tan <lftan.linux@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Ley Foon Tan <lftan@altera.com>,
	Ley Foon Tan <lftan.linux@gmail.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 3, 2015 at 5:54 PM, Ley Foon Tan <lftan@altera.com> wrote:
> This series of patch fixes the issues when work with multi-functions PCIe
> devices. Host controller can't access to endpoint with non-zero devfn, due to
> incorrect rootport devfn. It also add checking for TLP status and fix issue in
> interrupt probing.
>
> Tested on Ethernet adapter card with multi-functions enabled.
>
> Ley Foon Tan (3):
>   PCI: altera: fix incorrect devfn for requester ID
>   PCI: altera: check TLP completion status
>   PCI: altera: fix error when INTX is 4
>
>  drivers/pci/host/pcie-altera.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
>
Hi

Sorry, please ignore this patchset, Will resend again.

Thanks.

Regards
Ley Foon
