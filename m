Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from hqemgate14.nvidia.com ([216.228.121.143]:15220 "EHLO
	hqemgate14.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967549Ab3E3GRH convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 30 May 2013 02:17:07 -0400
From: Jay Agarwal <jagarwal@nvidia.com>
To: 'Stephen Warren' <swarren@wwwdotorg.org>
CC: "thierry.reding@avionic-design.de" <thierry.reding@avionic-design.de>,
	Laxman Dewangan <ldewangan@nvidia.com>,
	Prashant Gaikwad <pgaikwad@nvidia.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>,
	"linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	Juha Tukkinen <jtukkinen@nvidia.com>,
	Krishna Thota <kthota@nvidia.com>
Date: Thu, 30 May 2013 11:47:02 +0530
Subject: RE: [PATCH] Move PCIe node to correct place
Message-ID: <C79B248886DD134989C8FF6B096A91AB91B616BE9E@BGMAIL01.nvidia.com>
References: <1368626150-25395-1-git-send-email-jagarwal@nvidia.com>
 <5193B622.9020503@wwwdotorg.org>
In-Reply-To: <5193B622.9020503@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

> On 05/15/2013 07:55 AM, Jay Agarwal wrote:
> > Moving PCIe controller node to correct place so that it is sorted by
> > register address in .dtsi file
> 
> Reviewed-by: Stephen Warren <swarren@nvidia.com>
Hi Thierry,
If reviews are done, Can you please include this into your repository?

