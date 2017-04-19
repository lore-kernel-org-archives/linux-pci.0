Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 19 Apr 2017 11:26:52 +0100
From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
To: abhijit <abhijitnaik27@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: Doubt on first access for PCIe device
Message-ID: <20170419102652.GA23487@red-moon>
References: <50712b3b-2943-0b78-9413-257f33b26c3f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <50712b3b-2943-0b78-9413-257f33b26c3f@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Tue, Apr 11, 2017 at 07:45:40PM +0530, abhijit wrote:
> 
> Hi All,
> 
> I was referring Linux code for PCIe enumeration and I have one doubt
> w.r.t to very first operation that must be done on device.
> 
> Currently while scanning for device, we directly read vendor ID from
> device. But PCIE base specification
> "CB-PCI_Express_Base_4.0r0.7_November-11-2016.pdf" section 2.2.6.2
> specifies that,
> 
> "Functions must capture the Bus and Device Numbers supplied with all
> Type 0 Configuration Write Requests completed by the Function and
> supply these numbers in the Bus and Device Number fields of the
> Requester ID for all Requests initiated by the Device/Function."

Please note:

"for all Requests initiated by the Device/Function".
                  ^^^^^^^^^

> Here I am assuming, the completer ID will be device number and
> function number that will eventually programmed in to  device. In
> that case, my question is, without first write, how read
> request(VENDOR ID read) is serviced/routed?

That's not initiated by the endpoint device, it is routed by
requester ID, which is the requester ID of the configuration
request - ie master (ie root complex) requester ID.

Read 2.2.9 - Completion rules

HTH,
Lorenzo
