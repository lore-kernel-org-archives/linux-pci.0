Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:47274 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030711Ab2CNJYT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 14 Mar 2012 05:24:19 -0400
Message-ID: <4F60638F.20300@intel.com>
Date: Wed, 14 Mar 2012 11:23:27 +0200
From: Adrian Hunter <adrian.hunter@intel.com>
MIME-Version: 1.0
To: Alexander Stein <alexander.stein@systec-electronic.com>
CC: Chris Ball <cjb@laptop.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH v2] mmc: sdhci: check interrupt flags in ISR again
References: <4F60532E.4070103@intel.com> <1331715130-8505-1-git-send-email-alexander.stein@systec-electronic.com>
In-Reply-To: <1331715130-8505-1-git-send-email-alexander.stein@systec-electronic.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 14/03/12 10:52, Alexander Stein wrote:
> When using MSI it is possible that a new MSI is sent while an earlier
> MSI is currently handled. In this case SDHCI_INT_STATUS only contains
> SDHCI_INT_RESPONSE and the ISR would not be called again. But at the end
> of the ISR SDHCI_INT_DATA_END is now also pending which would be ignored.
> 
> Fix this by rereading the interrupt flags in the ISR until no interrupt
> we care is pending.
> 
> Signed-off-by: Alexander Stein <alexander.stein@systec-electronic.com>
> ---
> Changes in v2:
> * rearranged code a bit and added a maximum loop counter as suggested
>   by Adrian
> 
>  drivers/mmc/host/sdhci.c |   19 ++++++++++++-------
>  1 files changed, 12 insertions(+), 7 deletions(-)

Acked-by: Adrian Hunter <adrian.hunter@intel.com>
