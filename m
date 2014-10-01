Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-by2on0107.outbound.protection.outlook.com ([207.46.100.107]:51552
	"EHLO na01-by2-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751268AbaJAVRI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
	Wed, 1 Oct 2014 17:17:08 -0400
Date: Wed, 1 Oct 2014 14:16:57 -0700
From: Guenter Roeck <groeck@juniper.net>
To: Wolfram Sang <wsa@the-dreams.de>
CC: Danielle Costantino <danielle.costantino@gmail.com>,
	linux-i2c <linux-i2c@vger.kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Andrew Morton <akpm@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	Rajat Jain <rajatjain@juniper.net>
Subject: Re: Fwd: [Proposal] PM sleep children of inactive I2C bus segments
 off Masters in multi-master systems
Message-ID: <20141001211657.GA7904@svl-evodev-groeck.juniper.net>
References: <CAAVjN7dwS62EKMnuZc_P1UjkbRVk6RXqJ91GwWZ96bbY5Ct-rg@mail.gmail.com>
 <CAAVjN7eUmBVcAGPbcn3qsJ9M9uu2nkFoKHqGhhKGekZSceGiMw@mail.gmail.com>
 <20141001184304.GA6832@svl-evodev-groeck.juniper.net>
 <CAAVjN7edpkXYMHBm+wLegA_pc0hnm_YZf_z=Ni3h=EbDTmfegQ@mail.gmail.com>
 <20141001194115.GA6948@svl-evodev-groeck.juniper.net>
 <CAAVjN7fGRzyu7gxavJUay+K_Mm-0t1T_0Bysk6-sdaqu5=5k5A@mail.gmail.com>
 <20141001202058.GB6948@svl-evodev-groeck.juniper.net>
 <CAAVjN7e4nO579TfAJ5zMNe__Q9yU_-6naq4-0vm1rimespSrsw@mail.gmail.com>
 <20141001204302.GA7744@svl-evodev-groeck.juniper.net>
 <20141001211046.GA2368@katana>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20141001211046.GA2368@katana>
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Wed, Oct 01, 2014 at 11:10:47PM +0200, Wolfram Sang wrote:
> 
> > Maybe you can find an error code which with some level of confidence
> > reflects "lost mastership". Then you can implement whatever makes sense
> > for your use case in your user space application(s).
> 
> We have a documented fault code for ArbitrationLost and that is -EAGAIN
> (see Documentation/i2c/fault-codes). If a driver does use something
> else, patches are very welcome.
> 
> Other than that, I find this thread very confusing. Of course can
> another master modify the clients, this is what multi-master is all
> about, no?
> 
That is the point I was trying to make in one of my earlier replies.

Guenter
