Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-ob0-f175.google.com ([209.85.214.175]:43746 "EHLO
	mail-ob0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756457Ab3EaTZS (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Fri, 31 May 2013 15:25:18 -0400
Received: by mail-ob0-f175.google.com with SMTP id xn12so3805542obc.34
        for <linux-pci@vger.kernel.org>; Fri, 31 May 2013 12:25:18 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130531081623.GB17241@mtj.dyndns.org>
References: <1369987950-2894-1-git-send-email-shane.huang@amd.com> <20130531081623.GB17241@mtj.dyndns.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Fri, 31 May 2013 13:24:57 -0600
Message-ID: <CAErSpo4A_tuhsyErPOae5QgBdnUFK4f9kMitH0xUSnV6mYWYrA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] i2c-piix4: add AMD CZ SMBus device ID
To: Tejun Heo <tj@kernel.org>
Cc: Shane Huang <shane.huang@amd.com>,
	Jean Delvare <khali@linux-fr.org>,
	linux-i2c <linux-i2c@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	linux-ide@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Fri, May 31, 2013 at 2:16 AM, Tejun Heo <tj@kernel.org> wrote:
> On Fri, May 31, 2013 at 04:12:30PM +0800, Shane Huang wrote:
>> To add AMD CZ SMBus controller device ID.
>>
>> Signed-off-by: Shane Huang <shane.huang@amd.com>
>
> All three patches look good to me.
>
>  Reviewed-by: Tejun Heo <tj@kernel.org>
>
> Both 2 and 3 are dependent on the first patch, so it probably would be
> a good idea to route them together (probably w/ stable cc'd).  Who
> wants these?  Bjorn?

The pci_ids.h change is fine with me.  I don't care how they're
routed.  If you want me to pick them up, maybe Shane could collect up
the acks & reviewed-bys and add the appropriate stable tags and resend
the series to me.

Bjorn
