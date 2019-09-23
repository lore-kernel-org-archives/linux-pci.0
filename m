Return-Path: <SRS0=j7DB=XS=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2941C432C1
	for <linux-pci@archiver.kernel.org>; Mon, 23 Sep 2019 21:50:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6462E2053B
	for <linux-pci@archiver.kernel.org>; Mon, 23 Sep 2019 21:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1569275430;
	bh=uL09dUji+FB48rz9m57c3BRbd3Wt0dZwJd5rB9ibLic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LJvRlM4/NgKuFf4j28t9ejjZp8kwpLeplLTVXGjMRLgKvpIGyueb2zgJNV8pQCKSp
	 RqWGmfBlSKb/1xW4JCfHlhnZjsJJtrq8c4izrvnF4wQ40jXOVS0u+ZAg+w9zT87kpi
	 pV1nGwH6JMLOuCuXOZZZBOawRb5b/bdjVwn242j4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503114AbfIWVua (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 23 Sep 2019 17:50:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:56856 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389663AbfIWVu3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Sep 2019 17:50:29 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B5D582053B;
        Mon, 23 Sep 2019 21:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569275429;
        bh=uL09dUji+FB48rz9m57c3BRbd3Wt0dZwJd5rB9ibLic=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wQAK9extFxsky3WJhZyrFpApddpIWJSDKhmyYWWV6+15ZCgPPzWv7mE5+IFSI+VoZ
         Ltf3YyzbrmEZh0g+GRx4zagN7417PeHvk74Ld1OayLuPk338bCicV8JE1XYAjpfYPS
         mNIb7MBvoT6XspTuHBwoUia14v1GXp7vk1Wi7++0=
Date:   Mon, 23 Sep 2019 16:50:27 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [RFC/PATCH] PCI: Protect pci_reassign_bridge_resources() against
 concurrent addition/removal
Message-ID: <20190923215027.GA11938@google.com>
References: <02ca29627597445442bb14c069678e549429dace.camel@kernel.crashing.org>
 <20190821130827.GF14450@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190821130827.GF14450@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 21, 2019 at 08:08:27AM -0500, Bjorn Helgaas wrote:
> On Mon, Jun 24, 2019 at 02:32:19PM +1000, Benjamin Herrenschmidt wrote:
> > pci_reassign_bridge_resources() can be called by pci_resize_resource()
> > at runtime.
> > 
> > It will walk the PCI tree up and down, and isn't currently protected
> > against any changes or hotplug operation.
> > 
> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Applied to pci/resource for v5.4, thanks!

Dropped for now per Dan's bug report:
https://lore.kernel.org/r/20190904100303.GD7007@mwanda

> > ---
> > 
> > --- a/drivers/pci/setup-bus.c
> > +++ b/drivers/pci/setup-bus.c
> > @@ -2104,6 +2104,8 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
> >  	unsigned int i;
> >  	int ret;
> >  
> > +	down_read(&pci_bus_sem);
> > +
> >  	/* Walk to the root hub, releasing bridge BARs when possible */
> >  	next = bridge;
> >  	do {
> > @@ -2160,6 +2162,7 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
> >  	}
> >  
> >  	free_list(&saved);
> > +	up_read(&pci_bus_sem);
> >  	return 0;
> >  
> >  cleanup:
> > @@ -2188,6 +2191,7 @@ int pci_reassign_bridge_resources(struct pci_dev *bridge, unsigned long type)
> >  		pci_setup_bridge(bridge->subordinate);
> >  	}
> >  	free_list(&saved);
> > +	up_read(&pci_bus_sem);
> >  
> >  	return ret;
> >  }
> > 
