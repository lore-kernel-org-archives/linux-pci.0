Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34364 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751292AbcGLKTa (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jul 2016 06:19:30 -0400
MIME-Version: 1.0
In-Reply-To: <1466499193-1987-1-git-send-email-lftan@altera.com>
References: <1466499193-1987-1-git-send-email-lftan@altera.com>
From: Ley Foon Tan <lftan@altera.com>
Date: Tue, 12 Jul 2016 18:19:27 +0800
Message-ID: <CAFiDJ5-5sVZHFCXeSE-DQk+QkvQ400bxDB4FAtd5_fq4dZRMCA@mail.gmail.com>
Subject: Re: [PATCH 0/2] PCI: altera: fix link retrain
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	linux-pci <linux-pci@vger.kernel.org>,
	Ley Foon Tan <lftan.linux@gmail.com>,
	Ley Foon Tan <lftan@altera.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Jun 21, 2016 at 4:53 PM, Ley Foon Tan <lftan@altera.com> wrote:
>
> This 2 patches fix the issue before and after retrain link.
>
> Ley Foon Tan (2):
>   PCI: altera: check link status before retrain link
>   PCI: altera: Polling for link up status after retrain the link
>
>  drivers/pci/host/pcie-altera.c | 48 +++++++++++++++++++++++++++---------------
>  1 file changed, 31 insertions(+), 17 deletions(-)
>

Hi Bjorn

Do you any comment on these 2 patches?

Regards
Ley Foon
