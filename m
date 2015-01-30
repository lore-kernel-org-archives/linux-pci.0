Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from smtp.codeaurora.org ([198.145.11.231]:42992 "EHLO
	smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbbA3Vcm (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 30 Jan 2015 16:32:42 -0500
Message-ID: <54CBF878.2000109@codeaurora.org>
Date: Fri, 30 Jan 2015 13:32:40 -0800
From: Stephen Boyd <sboyd@codeaurora.org>
MIME-Version: 1.0
To: Michael Turquette <mturquette@linaro.org>,
	linux-kernel@vger.kernel.org
CC: Tanmay Inamdar <tinamdar@apm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH 2/3] pci: xgene: do not use clk-private.h
References: <1422653113-32688-1-git-send-email-mturquette@linaro.org> <1422653113-32688-3-git-send-email-mturquette@linaro.org>
In-Reply-To: <1422653113-32688-3-git-send-email-mturquette@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 01/30/15 13:25, Michael Turquette wrote:
> The X-Gene PCIe driver consumes clocks and does not provide them.
> Replace usage of clk-private.h with clk.h.
>
> Cc: Tanmay Inamdar <tinamdar@apm.com>
> Signed-off-by: Michael Turquette <mturquette@linaro.org>
> ---

I already sent this one through the pci tree
(29ef709195977d151199464b0c4ce4d8f193f244 in next) and it got picked up.
Sorry. I guess it doesn't hurt to also send it through the clk tree if
we can remove the entire header file.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project

