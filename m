Return-Path: <SRS0=zVIF=MH=vger.kernel.org=linux-pci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF49C43382
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 21:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3AA1920843
	for <linux-pci@archiver.kernel.org>; Tue, 25 Sep 2018 21:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="LxrpWFP/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3AA1920843
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-pci-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725733AbeIZEI7 (ORCPT <rfc822;linux-pci@archiver.kernel.org>);
        Wed, 26 Sep 2018 00:08:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:58874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725732AbeIZEI7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Sep 2018 00:08:59 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 797D320842;
        Tue, 25 Sep 2018 21:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1537912760;
        bh=ZGLlrEBeMIS7iK7MX4YszqXMkLF39Q0YA7YRtVHTOEM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LxrpWFP/pj4VD/MLRbzwdw8+V4Md8g+RiICsR0PE7emyFnR6VB/+sigAzQeFbftKz
         zjzXFsCNkVwE8MDbpMLqgyXw+FjRetC9/hgfFZkWdzAhvcVkV7pPUUaPibysZMNERX
         m5mc31p0mIs9lP38Ro9v6TuCJFnNehDf9RWi8S88=
Date:   Tue, 25 Sep 2018 16:59:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sinan Kaya <okaya@kernel.org>
Cc:     linux-pci@vger.kernel.org, alex.williamson@redhat.com,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Frank Haverkamp <haver@linux.vnet.ibm.com>,
        "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harish Patil <harish.patil@cavium.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Dept-GELinuxNICDev@cavium.com,
        "David S. Miller" <davem@davemloft.net>,
        Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
        Edward Cree <ecree@solarflare.com>,
        Bert Kenward <bkenward@solarflare.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Anton Vasilyev <vasilyev@ispras.ru>
Subject: Re: [PATCH v4 2/6] PCI: Expose reset_type to users of
 pci_reset_function()
Message-ID: <20180925215918.GH80129@bhelgaas-glaptop.roam.corp.google.com>
References: <20180919163037.13497-1-okaya@kernel.org>
 <20180919163037.13497-3-okaya@kernel.org>
 <20180925204632.GC80129@bhelgaas-glaptop.roam.corp.google.com>
 <1fdf239a-1928-9270-cb43-cde84715192b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1fdf239a-1928-9270-cb43-cde84715192b@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 25, 2018 at 04:52:38PM -0400, Sinan Kaya wrote:
> On 9/25/2018 4:46 PM, Bjorn Helgaas wrote:
> > > Looking to have more control between the users of the API vs. what the API
> > > can do internally. The new reset_type tells the PCI core about the bounds
> > > of the request.
> > I'd like to know why you chose PCI_RESET_ANY for these drivers.
> > 
> 
> PCI_RESET_ANY was chosen to match the existing behavior in the code.
> 
> Current pci_reset_function() tries all reset types one by one until
> it returns 0. By specifying PCI_RESET_ANY, we get the same thing.

That would be useful information for the changelog.
