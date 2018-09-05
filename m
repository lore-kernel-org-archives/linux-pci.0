Return-Path: <okaya@kernel.org>
Return-Path: <okaya@kernel.org>
Subject: Re: [RFC] PCI: add support for Immediate Readiness
To: Bjorn Helgaas <helgaas@kernel.org>,
 Felipe Balbi <felipe.balbi@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
References: <20180802113635.7097-1-felipe.balbi@linux.intel.com>
 <15a43051-6b0f-1545-dc8f-b56b1513897b@kernel.org>
 <874lgcufsu.fsf@linux.intel.com>
 <407fa9ef-dcbe-e803-f72e-cbea468592bf@kernel.org>
 <20180904181126.GG107892@bhelgaas-glaptop.roam.corp.google.com>
 <87y3cgbjyf.fsf@linux.intel.com>
 <20180905164909.GJ107892@bhelgaas-glaptop.roam.corp.google.com>
From: Sinan Kaya <okaya@kernel.org>
Message-ID: <f837db48-065f-4394-5512-a74716a52e8e@kernel.org>
Date: Wed, 5 Sep 2018 09:54:10 -0700
MIME-Version: 1.0
In-Reply-To: <20180905164909.GJ107892@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-pci.vger.kernel.org>

On 9/5/2018 9:49 AM, Bjorn Helgaas wrote:
> pci_dev_wait() is connected with CRS.  There's some reason that
> function doesn't actually looks for CRS responses, which I can't
> remember right now.  But you can look it up in the changelogs.
> 

We wanted to be able to support virtual functions (that can't read
vendor id) as well as systems without CRS visibility support. That
was the reason why we are polling a well known register such as
command status against ~0 rather than the vendor id register.

> So I don't think we should put the Immediate Readiness check in
> pci_dev_wait().

I agree, it should be outside of pci_dev_wait()
