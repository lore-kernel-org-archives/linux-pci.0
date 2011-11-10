Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from rcsinet15.oracle.com ([148.87.113.117]:28546 "EHLO
	rcsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696Ab1KJTLR (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2011 14:11:17 -0500
Message-ID: <4EBC21C0.5070806@oracle.com>
Date: Thu, 10 Nov 2011 11:10:56 -0800
From: Yinghai Lu <yinghai.lu@oracle.com>
MIME-Version: 1.0
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
CC: Jesse Barnes <jbarnes@virtuousgeek.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 2/2] pciehp: wait 100 ms after Link Training check
References: <4EB88238.4050409@oracle.com> <4EB8F434.6090003@jp.fujitsu.com> <4EB94A51.6070809@oracle.com> <4EB9A50D.1040302@oracle.com> <4EBB7F9B.8050703@jp.fujitsu.com> <4EBB8058.6090500@jp.fujitsu.com>
In-Reply-To: <4EBB8058.6090500@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/09/2011 11:42 PM, Kenji Kaneshige wrote:

> If the port supports Link speeds greater than 5.0 GT/s, we must wait
> for 100 ms after Link training completes before sending configuration
> request.
> 
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>



Acked-by: Yinghai Lu <yinghai@kernel.org>
Tested-by: Yinghai Lu <yinghai@kernel.org>
