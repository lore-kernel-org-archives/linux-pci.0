Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mms2.broadcom.com ([216.31.210.18]:2668 "EHLO mms2.broadcom.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755043Ab3HFLNG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Tue, 6 Aug 2013 07:13:06 -0400
Message-ID: <1375787574.31311.1.camel@lb-tlvb-eilong.il.broadcom.com>
Subject: Re: [PATCH V2 3/4] bnx2x: Use pci_wait_for_pending_transaction
 instead of for loop
From: "Eilon Greenstein" <eilong@broadcom.com>
Reply-to: eilong@broadcom.com
To: "Vipul Pandya" <vipul@chelsio.com>
cc: linux-pci@vger.kernel.org, bhelgaas@google.com, leedom@chelsio.com,
	tomreu@chelsio.com, divy@chelsio.com, dm@chelsio.com,
	nirranjan@chelsio.com, netdev@vger.kernel.org
Date: Tue, 6 Aug 2013 14:12:54 +0300
In-Reply-To: <1375784319-25760-4-git-send-email-vipul@chelsio.com>
References: <1375784319-25760-1-git-send-email-vipul@chelsio.com>
 <1375784319-25760-4-git-send-email-vipul@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, 2013-08-06 at 15:48 +0530, Vipul Pandya wrote:
> From: Casey Leedom <leedom@chelsio.com>
> 
> New routine has been added to avoid duplication of waiting for pending pci
> transaction code. This patch makes use of that routine.
> 
> Signed-off-by: Casey Leedom <leedom@chelsio.com>
> Signed-off-by: Vipul Pandya <vipul@chelsio.com>

Thanks Casey!

Acked-by: Eilon Greenstein <eilong@broadcom.com>


