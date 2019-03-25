Return-Path: <SRS0=Cb4Y=R4=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD2F5C43381
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 13:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E81C2146F
	for <linux-pci@archiver.kernel.org>; Mon, 25 Mar 2019 13:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1553521995;
	bh=5QU3yfdxQrj/MGdX1DxJPj2H+XWm57iCrYYHzjDcmGk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=WzkHMK9X/etb1hi05e8eC1qK6hngBFS7yEfCGzqEstvHBJQPKDjkRpGiHQTYtkmTr
	 Z5SGM0YC5eaRRlcjObOaA6z4V21QabEnpUfNiDh66rEqvViHwRMAtdRzsDdA4Osv6i
	 s+mA3EHnOgkGM4HOMx1xjEvAJoUxh9v5AP6g8wew=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729010AbfCYNxO (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Mon, 25 Mar 2019 09:53:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:32772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727111AbfCYNxO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Mar 2019 09:53:14 -0400
Received: from localhost (173-25-63-173.client.mchsi.com [173.25.63.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C6FCD20830;
        Mon, 25 Mar 2019 13:53:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1553521994;
        bh=5QU3yfdxQrj/MGdX1DxJPj2H+XWm57iCrYYHzjDcmGk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aRQhb7nkMv149CIv5fGgnvY2EZQD23FCX2Bfbx7Xj8rJckGQ+KmQ41kg+ImNSqGNr
         k8uy77uRBeOuu80Au40pYRzNd5gAevksDcxciGwg1+qidmHQ/+PKV7gDQtbKqZ+/TN
         /tDRQX7GTJgVF1gG/XEC3vVBPhyWXdGZTEQGXBeU=
Date:   Mon, 25 Mar 2019 08:53:12 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Cc:     "robh+dt@kernel.org" <robh+dt@kernel.org>,
        Mark Rutland <Mark.Rutland@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Jeremy Linton <Jeremy.Linton@arm.com>,
        Grant Likely <Grant.Likely@arm.com>,
        Robin Murphy <Robin.Murphy@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH 1/2] dt-bindings: Add external-facing PCIe port property
Message-ID: <20190325135312.GQ251185@google.com>
References: <20190318182124.53859-1-jean-philippe.brucker@arm.com>
 <20190318182124.53859-2-jean-philippe.brucker@arm.com>
 <20190320220338.GH251185@google.com>
 <598b0675-38b2-9e52-d903-016dc548756c@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <598b0675-38b2-9e52-d903-016dc548756c@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Mar 25, 2019 at 12:59:48PM +0000, Jean-Philippe Brucker wrote:
> On 20/03/2019 22:03, Bjorn Helgaas wrote:
> > On Mon, Mar 18, 2019 at 06:21:23PM +0000, Jean-Philippe Brucker wrote:

> >> +- external-facing:
> >> +   When present, the port is external facing. All bridges and endpoints
> >> +   downstream of this port are external to the machine.
> > 
> > Maybe include a note about why this is important, ie, we care because
> > malicious devices may be attached to an external port?  I know you
> > have that in the commit log but it would be more visible here.
> > 
> > Elsewhere you use "external-facing", here too for consistency?
> 
> Makes sense, I'll add a note. I currently have:
> 
> - external-facing:
>    When present, the port is external-facing. All bridges and endpoints
>    downstream of this port are external to the machine. The OS can, for
>    example, use this information to identify devices that cannot be
>    trusted with relaxed DMA protection, as users could easily attach
>    malicious devices to this port.

Looks good to me!
