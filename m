Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from kirsty.vergenet.net ([202.4.237.240]:38177 "EHLO
        kirsty.vergenet.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754220AbeDZHnn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Apr 2018 03:43:43 -0400
Date: Thu, 26 Apr 2018 09:43:39 +0200
From: Simon Horman <horms@verge.net.au>
To: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Subject: Re: [PATCH] PCI: rcar: Reuse generic
 pci_parse_request_of_pci_ranges() function
Message-ID: <20180426074336.po7lmeg24ptswqwr@verge.net.au>
References: <1524669685-8265-1-git-send-email-vladimir_zapolskiy@mentor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1524669685-8265-1-git-send-email-vladimir_zapolskiy@mentor.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Apr 25, 2018 at 06:21:25PM +0300, Vladimir Zapolskiy wrote:
> The non-functional change removes a custom function to parse and
> allocate PCI resources in favour of pci_parse_request_of_pci_ranges().
> 
> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>

Acked-by: Simon Horman <horms+renesas@verge.net.au>
