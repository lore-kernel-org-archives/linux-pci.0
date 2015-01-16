Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from shards.monkeyblade.net ([149.20.54.216]:55961 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932382AbbAPAOe (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jan 2015 19:14:34 -0500
Date: Thu, 15 Jan 2015 19:14:32 -0500 (EST)
Message-Id: <20150115.191432.1173958067874072654.davem@davemloft.net>
To: yinghai@kernel.org
Cc: bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com,
	wangyijing@huawei.com, sam@ravnborg.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 10/10] PCI, sparc: clip firmware assigned resource
 under parent bridge's
From: David Miller <davem@davemloft.net>
In-Reply-To: <1421296297-6371-11-git-send-email-yinghai@kernel.org>
References: <1421296297-6371-1-git-send-email-yinghai@kernel.org>
	<1421296297-6371-11-git-send-email-yinghai@kernel.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

From: Yinghai Lu <yinghai@kernel.org>
Date: Wed, 14 Jan 2015 20:31:37 -0800

> Some bios put range that is not fully coverred by root bus resources.
> Try to clip them and update them in pci bridge bars.
> 
> We'd like to fix other arches instead of just x86.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=85491
> Reported-by: Marek Kordik <kordikmarek@gmail.com>
> Fixes: 5b28541552ef ("PCI: Restrict 64-bit prefetchable bridge windows to 64-bit resources")
> Signed-off-by: Yinghai Lu <yinghai@kernel.org>

Acked-by: David S. Miller <davem@davemloft.net>
