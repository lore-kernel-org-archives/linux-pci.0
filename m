Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:50978 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751015AbeCNMX0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 14 Mar 2018 08:23:26 -0400
Message-ID: <1521029854.4511.12.camel@suse.com>
Subject: Re: [PATCH 2/3] usb: host: pci: introduce PCI vendor ID for Netlogic
From: Oliver Neukum <oneukum@suse.com>
To: Richard Leitner <dev@g0hl1n.net>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-usb@vger.kernel.org
Cc: bhelgaas@google.com, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, richard.leitner@skidata.com
Date: Wed, 14 Mar 2018 13:17:34 +0100
In-Reply-To: <20180314102933.21367-3-dev@g0hl1n.net>
References: <20180314102933.21367-1-dev@g0hl1n.net>
         <20180314102933.21367-3-dev@g0hl1n.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Am Mittwoch, den 14.03.2018, 11:29 +0100 schrieb Richard Leitner:
> From: Richard Leitner <richard.leitner@skidata.com>
> 
> Replace the hardcoded PCI vendor ID of Netlogic with a definition in
> pci_ids.h

Hi,

in general, why?
Does this patch generate any benefit for any developer
reading the source? I don't see it. Does it cause an
issue for anybody who has a log file with the nummerical
ID and needs to grep for it? Yes it does.

Where is the point of this patch?

	Regards
		Oliver
