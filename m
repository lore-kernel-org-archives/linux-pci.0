Return-Path: <jonathan.yong@intel.com>
Return-Path: <jonathan.yong@intel.com>
Message-ID: <575F5EAC.2030904@intel.com>
Date: Tue, 14 Jun 2016 09:32:28 +0800
From: "Yong, Jonathan" <jonathan.yong@intel.com>
MIME-Version: 1.0
To: Bjorn Helgaas <helgaas@kernel.org>
CC: linux-pci@vger.kernel.org, bhelgaas@google.com
Subject: Re: [PATCH v5] PCI: PTM preliminary implementation
References: <1462956446-27361-1-git-send-email-jonathan.yong@intel.com> <1462956446-27361-2-git-send-email-jonathan.yong@intel.com> <20160613185648.GA6901@localhost>
In-Reply-To: <20160613185648.GA6901@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 06/14/2016 02:56, Bjorn Helgaas wrote:
> I'm also a little confused about how Root Complex Integrated Endpoints
> are supposed to use PTM, since they don't have an upstream bridge.
> Maybe it has to do with an RCRB (Root Complex Register Block, spec
> r3.1, sec 7.2.3)?  I don't think Linux really has any support for that
> (yet).

The spec (7.32.3 PTM Control Register) says:

For Root Complex Integrated Endpoints, system software must set this 
field to the value reported in the Local Clock Granularity field by the 
associated PTM Time Source.

I'm not familiar with RC integrated endpoints either. I'm guessing 
whatever device 0, function 0 on the "bus"? Just copy the granularity 
value over?
