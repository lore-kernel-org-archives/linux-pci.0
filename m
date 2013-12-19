Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from top.free-electrons.com ([176.31.233.9]:59695 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751690Ab3LSJN1 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2013 04:13:27 -0500
Date: Thu, 19 Dec 2013 10:13:23 +0100
From: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To: Sachin Kamat <sachin.kamat@linaro.org>
Cc: linux-pci@vger.kernel.org, jason@lakedaemon.net,
	bhelgaas@google.com
Subject: Re: [PATCH Resend 1/1] PCI: mvebu: Remove redundant of_match_ptr
Message-ID: <20131219101323.56422c4d@skate>
In-Reply-To: <1387443899-7149-1-git-send-email-sachin.kamat@linaro.org>
References: <1387443899-7149-1-git-send-email-sachin.kamat@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Dear Sachin Kamat,

On Thu, 19 Dec 2013 14:34:59 +0530, Sachin Kamat wrote:
> mvebu_pcie_of_match_table is always compiled in. Hence of_match_ptr is
> not required.
> 
> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
> Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
> ---
>  drivers/pci/host/pci-mvebu.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
