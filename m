Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: Doubt on first access for PCIe device
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <50712b3b-2943-0b78-9413-257f33b26c3f@gmail.com>
From: abhijit <abhijitnaik27@gmail.com>
Message-ID: <0dacae5d-ab2c-d4ac-c3e3-ca3bd831f7ba@gmail.com>
Date: Fri, 21 Apr 2017 15:37:25 +0530
MIME-Version: 1.0
In-Reply-To: <50712b3b-2943-0b78-9413-257f33b26c3f@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

Thank you very much for reply.

As you mentioned I noted that, "If a Function must generate a Completion 
prior to the initial device Configuration Write Request, 0’s must be 
entered into the Bus Number and Device Number fields"

By above statement this means that completion ID will be 0x0000. For the 
very first device on any bus,  device number will be 0 and function 
number will be 0.

Isn't completer (for configuration read) packet will be addressing 
itself instead of root complex with bus, device and function number 0?

Regards,
     Abhijit


On Tuesday 11 April 2017 07:45 PM, abhijit wrote:
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
> Type 0 Configuration Write Requests completed by the Function and supply
> these numbers in the Bus and Device Number fields of the Requester ID
> for all Requests initiated by the Device/Function."
>
> Here I am assuming, the completer ID will be device number and function
> number that will eventually programmed in to  device. In that case, my
> question is, without first write, how read request(VENDOR ID read) is
> serviced/routed?
>
> Sorry I am feeling bit confused, help will be appreciated.
