Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from avon.wwwdotorg.org ([70.85.31.133]:42208 "EHLO
	avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758866Ab3EOQV6 (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 15 May 2013 12:21:58 -0400
Message-ID: <5193B622.9020503@wwwdotorg.org>
Date: Wed, 15 May 2013 10:21:54 -0600
From: Stephen Warren <swarren@wwwdotorg.org>
MIME-Version: 1.0
To: Jay Agarwal <jagarwal@nvidia.com>
CC: thierry.reding@avionic-design.de, ldewangan@nvidia.com,
	pgaikwad@nvidia.com, linux-arm-kernel@lists.infradead.org,
	linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, jtukkinen@nvidia.com, kthota@nvidia.com
Subject: Re: [PATCH] Move PCIe node to correct place
References: <1368626150-25395-1-git-send-email-jagarwal@nvidia.com>
In-Reply-To: <1368626150-25395-1-git-send-email-jagarwal@nvidia.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 05/15/2013 07:55 AM, Jay Agarwal wrote:
> Moving PCIe controller node to correct place so
> that it is sorted by register address in .dtsi file

Reviewed-by: Stephen Warren <swarren@nvidia.com>
