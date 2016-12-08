Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:30581 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752510AbcLHSxW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Dec 2016 13:53:22 -0500
Date: Thu, 8 Dec 2016 13:53:10 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: Juergen Gross <jgross@suse.com>, f@char.us.oracle.com
Cc: Konrad Rzeszutek Wilk <konrad@kernel.org>,
        linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
        boris.ostrovsky@oracle.com, bhelgaas@google.com, x86@kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] xen/pci: Bubble up error and fix description.
Message-ID: <20161208185310.GA31758@char.us.oracle.com>
References: <1481034501-716-1-git-send-email-konrad.wilk@oracle.com>
 <cce4b9bd-0659-297c-e911-3b2a6197f496@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cce4b9bd-0659-297c-e911-3b2a6197f496@suse.com>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Dec 08, 2016 at 07:58:29AM +0100, Juergen Gross wrote:
> On 06/12/16 15:28, Konrad Rzeszutek Wilk wrote:
> > The function is never called under PV guests, and only shows up
> > when MSI (or MSI-X) cannot be allocated. Convert the message
> > to include the error value.
> > 
> > Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> 
> Commited to xen/tip.git for-linus-4.10

Thank you!
> 
> 
> Juergen
> 
