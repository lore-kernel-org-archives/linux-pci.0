Return-Path: <SRS0=ji5Z=AH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 090FAC433DF
	for <linux-pci@archiver.kernel.org>; Fri, 26 Jun 2020 04:46:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD850207D8
	for <linux-pci@archiver.kernel.org>; Fri, 26 Jun 2020 04:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593146803;
	bh=sYXojlFL6sCFl3kYEgJC5h64bcZLjgtXUZGxEjWBECc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=y1R4q0wOK5GE7YbK1xkMu10UMtg8IinU0fOdLDiDG2WKaiau3bMIxMTrcyReXAeNl
	 x64fe9Y6JIEzNENjlW24XU1CQcEOzVCBqq4+5CNzmrm41ClbxtT+Fm4RKDBIswJnTg
	 3yyubheJmj7Z47qx6RWTekK4QtzPzy7NTqvw1wc0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbgFZEqm (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Fri, 26 Jun 2020 00:46:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:47632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725768AbgFZEqm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 26 Jun 2020 00:46:42 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 75CAB2078D;
        Fri, 26 Jun 2020 04:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593146802;
        bh=sYXojlFL6sCFl3kYEgJC5h64bcZLjgtXUZGxEjWBECc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sBYXjOulw0KUPwGyeCBx0vFkeiT4sa/XocCqGN4/2VrbdXdymhwIjU0ModQyNVWYm
         L8yGUItrvVLNVGIPVoi3AyVOmWPjtpwg34/e6biRNOR23p+dKBSnpWCwdhJ3NJ8I5q
         ObOeFjcxHfUH/6dBi5hcuvACbwA6/9+I+1BcL/FI=
Date:   Fri, 26 Jun 2020 06:46:39 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Rajat Jain <rajatja@google.com>
Cc:     David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, iommu@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Raj Ashok <ashok.raj@intel.com>,
        lalithambika.krishnakumar@intel.com,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Prashant Malani <pmalani@google.com>,
        Benson Leung <bleung@google.com>,
        Todd Broch <tbroch@google.com>,
        Alex Levin <levinale@google.com>,
        Mattias Nissler <mnissler@google.com>,
        Rajat Jain <rajatxjain@gmail.com>,
        Bernie Keany <bernie.keany@intel.com>,
        Aaron Durbin <adurbin@google.com>,
        Diego Rivas <diegorivas@google.com>,
        Duncan Laurie <dlaurie@google.com>,
        Furquan Shaikh <furquan@google.com>,
        Jesse Barnes <jsbarnes@google.com>,
        Christian Kellner <christian@kellner.me>,
        Alex Williamson <alex.williamson@redhat.com>, oohall@gmail.com
Subject: Re: [PATCH 2/2] pci: Add parameter to disable attaching untrusted
 devices
Message-ID: <20200626044639.GA201124@kroah.com>
References: <20200626002710.110200-1-rajatja@google.com>
 <20200626002710.110200-2-rajatja@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200626002710.110200-2-rajatja@google.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Jun 25, 2020 at 05:27:10PM -0700, Rajat Jain wrote:
> Introduce a PCI parameter that disables the automatic attachment of
> untrusted devices to their drivers.

You didn't document this new api anywhere :(
