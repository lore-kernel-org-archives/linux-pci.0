Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from ale.deltatee.com ([207.54.116.67]:37053 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750720AbdFQQUM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 17 Jun 2017 12:20:12 -0400
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20170615203729.9009-1-logang@deltatee.com>
 <20170615203729.9009-5-logang@deltatee.com> <20170617051429.GF6040@kroah.com>
Cc: linux-ntb@googlegroups.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jon Mason <jdmason@kudzu.us>,
        Dave Jiang <dave.jiang@intel.com>,
        Allen Hubbe <Allen.Hubbe@emc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Stephen Bates <sbates@raithlin.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <f7f59aaf-f525-b03f-7492-9c372bc752b9@deltatee.com>
Date: Sat, 17 Jun 2017 10:20:00 -0600
MIME-Version: 1.0
In-Reply-To: <20170617051429.GF6040@kroah.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [RFC PATCH 04/13] switchtec: add link event notifier block
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>



On 16/06/17 11:14 PM, Greg Kroah-Hartman wrote:
> You do know about ftrace, right?  It's good to drop debugging code like
> this for "final" versions.

I've never actually used it but maybe I should give it a try. I'll
remove these debug lines.

>> +
>> +	blocking_notifier_call_chain(&stdev->link_notifier, 0, stdev);
>> +}
> 
> Do you really need a notifier call chain?  How many different things are
> going to "hook up" to this?  I ask as they tend to get really messy over
> time while direct callbacks are easier to handle and manage.

Ok, understood. I only expect the one callback at this time so I'll
change it to a single function pointer.

Logan
