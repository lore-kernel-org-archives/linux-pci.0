Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from cpsmtpb-ews04.kpnxchange.com ([213.75.39.7]:51619 "EHLO
	cpsmtpb-ews04.kpnxchange.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750972Ab3A2Kff (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 29 Jan 2013 05:35:35 -0500
Message-ID: <1359455732.1345.46.camel@x61.thuisdomein>
Subject: Re: pciehp: errors on resume
From: Paul Bolle <pebolle@tiscali.nl>
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: Oliver Neukum <oneukum@suse.de>, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Date: Tue, 29 Jan 2013 11:35:32 +0100
In-Reply-To: <51072F83.7040102@cn.fujitsu.com>
References: <1359377173.1345.25.camel@x61.thuisdomein>
	 <51072F83.7040102@cn.fujitsu.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Gu,

On Tue, 2013-01-29 at 10:10 +0800, Gu Zheng wrote:
> I think cause of the issue you mentioned is the device already exists when we resume.
> Because we do not really suspend/remove the device when suspend, the device still exists, so 
> we try to add the device when resume will failed. The suspend routine does not match the resume,
> it seems a bug here.

Thanks. So should the fix here be to actually suspend and remove this
device? (Note that pciehp_suspend() is now basically a NOP.)


Paul Bolle

