Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f171.google.com ([209.85.214.171]:64574 "EHLO
	mail-ob0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750748Ab3FDSEz (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Tue, 4 Jun 2013 14:04:55 -0400
Received: by mail-ob0-f171.google.com with SMTP id dn14so954123obc.2
        for <linux-pci@vger.kernel.org>; Tue, 04 Jun 2013 11:04:55 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAErSpo4kvEkUtYFXnoE8yDnHsUD8Z6EUrKaXaJ=yy4yMcJ0veA@mail.gmail.com>
References: <F7B8FD780A346D46A0042F5C63B06AE785E3B2@SHSMSX102.ccr.corp.intel.com>
 <20130520224824.GA31740@google.com> <CF6E51640088844D9CADE5541A7C2FEB33EBE413@CMEXMB1.ad.emulex.com>
 <CAErSpo4kvEkUtYFXnoE8yDnHsUD8Z6EUrKaXaJ=yy4yMcJ0veA@mail.gmail.com>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Tue, 4 Jun 2013 12:04:35 -0600
Message-ID: <CAErSpo5OMuW_fg4DYAqg=xcY8USDhC89Mgt66BwoSzss41UKMQ@mail.gmail.com>
Subject: Re: Subject : [ PATCH ] pci-reset-error_state-to-pci_channel_io_normal-at-report_slot_reset
To: "Liu, Joseph" <Joseph.Liu@emulex.com>
Cc: "Zhang, LongX" <longx.zhang@intel.com>,
	"linasvepstas@gmail.com" <linasvepstas@gmail.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

I'm not sure where we are with this patch.  I think Joseph initially
reported a problem (though I haven't actually seen that), and this
patch fixed it, so it seems like there's something we want to do here.

Bjorn
