Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:53915 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751243AbcLHG6c (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 8 Dec 2016 01:58:32 -0500
Subject: Re: [PATCH] xen/pci: Bubble up error and fix description.
To: Konrad Rzeszutek Wilk <konrad@kernel.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, bhelgaas@google.com, x86@kernel.org,
        linux-pci@vger.kernel.org
References: <1481034501-716-1-git-send-email-konrad.wilk@oracle.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <cce4b9bd-0659-297c-e911-3b2a6197f496@suse.com>
Date: Thu, 8 Dec 2016 07:58:29 +0100
MIME-Version: 1.0
In-Reply-To: <1481034501-716-1-git-send-email-konrad.wilk@oracle.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On 06/12/16 15:28, Konrad Rzeszutek Wilk wrote:
> The function is never called under PV guests, and only shows up
> when MSI (or MSI-X) cannot be allocated. Convert the message
> to include the error value.
> 
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Commited to xen/tip.git for-linus-4.10


Juergen

