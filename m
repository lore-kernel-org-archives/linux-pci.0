Return-Path: <SRS0=sOfQ=A3=linuxfoundation.org=gregkh@kernel.org>
Return-Path: <SRS0=sOfQ=A3=linuxfoundation.org=gregkh@kernel.org>
Date: Tue, 26 Sep 2017 08:51:19 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Nicolai Stange <nstange@suse.de>, Bjorn Helgaas <bhelgaas@google.com>,
	Adrian Salido <salidoa@google.com>,
	Sasha Levin <sasha.levin@oracle.com>, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/3] driver core: platform: Don't read past the end of
 "driver_override" buffer
Message-ID: <20170926065119.GA6250@kroah.com>
References: <20170911074542.16777-1-nstange@suse.de>
 <20170911074542.16777-4-nstange@suse.de>
 <20170925235000.GI15970@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170925235000.GI15970@bhelgaas-glaptop.roam.corp.google.com>
List-ID: <linux-pci.vger.kernel.org>

On Mon, Sep 25, 2017 at 06:50:00PM -0500, Bjorn Helgaas wrote:
> Greg, I assume you'll deal with this one?  Just let me know if I
> should do something with it.

I've already applied it to my driver-core-next tree, thanks.

greg k-h
