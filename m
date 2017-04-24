Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: Doubt on first access for PCIe device
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
References: <50712b3b-2943-0b78-9413-257f33b26c3f@gmail.com>
 <20170419102652.GA23487@red-moon>
 <CANaY3hNcB0Yk=2f7S+J2r+wtd6T7mLd+ZNprNHFkMegZzvx7pQ@mail.gmail.com>
 <20170421155900.GA19059@red-moon>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
From: abhijit <abhijitnaik27@gmail.com>
Message-ID: <de02b73d-7eb5-b6eb-9e66-2919d442473e@gmail.com>
Date: Mon, 24 Apr 2017 11:52:27 +0530
MIME-Version: 1.0
In-Reply-To: <20170421155900.GA19059@red-moon>
Content-Type: text/plain; charset=windows-1252; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Lorenzo,

Yes that's true..

My question is: what if EP function default completer ID means BDF has 
values = 0(meaning B = 0, D = 0, f = 0) and Root complex requester ID 
also has same BDF, that is 0.

Is that valid case as per PCIe standard, as in this case, requester ID 
and completion ID have same BDF?

Thank you very much for your replies

Regards,
     Abhijit


On Friday 21 April 2017 09:29 PM, Lorenzo Pieralisi wrote:
> On Fri, Apr 21, 2017 at 03:33:45PM +0530, abhijit naik wrote:
>>    Hi Lorenzo,
>>    Thank you very much for reply.
>>    As you mentioned I noted that, "If a Function must generate a Completion
>>    prior to the initial device Configuration Write Request, 0's must be
>>    entered into the Bus Number and Device Number fields"
>>    By above statement this means that completion ID will be 0x0000. For the
>>    first device on any bus,  device number will be 0 and function number will
>>    be 0.
>>    Isn't completer (for configuration read) packet will be addressing itself
>>    instead of root complex with bus, device and function number 0?
>
> I don't understand what you are asking. The completion (containing
> the read data) is routed back to the initiator via ID (of the requester)
> routing.
>
> 2.2.4.2
> 2.2.9
>
> Lorenzo
>
>>    On Wed, Apr 19, 2017 at 3:56 PM, Lorenzo Pieralisi
>>    <lorenzo.pieralisi@arm.com> wrote:
>>
>>      On Tue, Apr 11, 2017 at 07:45:40PM +0530, abhijit wrote:
>>      >
>>      > Hi All,
>>      >
>>      > I was referring Linux code for PCIe enumeration and I have one doubt
>>      > w.r.t to very first operation that must be done on device.
>>      >
>>      > Currently while scanning for device, we directly read vendor ID from
>>      > device. But PCIE base specification
>>      > "CB-PCI_Express_Base_4.0r0.7_November-11-2016.pdf" section 2.2.6.2
>>      > specifies that,
>>      >
>>      > "Functions must capture the Bus and Device Numbers supplied with all
>>      > Type 0 Configuration Write Requests completed by the Function and
>>      > supply these numbers in the Bus and Device Number fields of the
>>      > Requester ID for all Requests initiated by the Device/Function."
>>
>>      Please note:
>>      "for all Requests initiated by the Device/Function".
>>                        ^^^^^^^^^
>>      > Here I am assuming, the completer ID will be device number and
>>      > function number that will eventually programmed in to  device. In
>>      > that case, my question is, without first write, how read
>>      > request(VENDOR ID read) is serviced/routed?
>>
>>      That's not initiated by the endpoint device, it is routed by
>>      requester ID, which is the requester ID of the configuration
>>      request - ie master (ie root complex) requester ID.
>>
>>      Read 2.2.9 - Completion rules
>>
>>      HTH,
>>      Lorenzo
>>
>>    --
>>    Best wishes,
>>    Abhijit Naik
