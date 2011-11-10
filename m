Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from acsinet15.oracle.com ([141.146.126.227]:60288 "EHLO
	acsinet15.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751696Ab1KJTKx (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 10 Nov 2011 14:10:53 -0500
Message-ID: <4EBC219B.5010403@oracle.com>
Date: Thu, 10 Nov 2011 11:10:19 -0800
From: Yinghai Lu <yinghai.lu@oracle.com>
MIME-Version: 1.0
To: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>
CC: Jesse Barnes <jbarnes@virtuousgeek.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 1/2] pciehp: wait 1000 ms before Link Training check
References: <4EB88238.4050409@oracle.com> <4EB8F434.6090003@jp.fujitsu.com> <4EB94A51.6070809@oracle.com> <4EB9A50D.1040302@oracle.com> <4EBB7F9B.8050703@jp.fujitsu.com> <4EBB7FF5.1040109@jp.fujitsu.com>
In-Reply-To: <4EBB7FF5.1040109@jp.fujitsu.com>
Content-Type: text/plain; charset=ISO-2022-JP
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 11/09/2011 11:40 PM, Kenji Kaneshige wrote:

> We need to wait for 1000 ms after Data Link Layer Link Active (DLLLA)
> bit reads 1b before sending configuration request. Currently pciehp
> does this wait after checking Link Training (LT) bit. But we need it
> before checking LT bit because LT is still set even after DLLLA bit is
> set on some platforms.
> 
> Signed-off-by: Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>


Acked-by: Yinghai Lu <yinghai@kernel.org>
Tested-by: Yinghai Lu <yinghai@kernel.org>
