Return-Path: <SRS0=+V2B=YM=synopsys.com=Joao.Pinto@kernel.org>
Return-Path: <SRS0=+V2B=YM=synopsys.com=Joao.Pinto@kernel.org>
Subject: Re: [PATCH] pci: rename *host* directory to *controller*
To: Kishon Vijay Abraham I <kishon@ti.com>, Joao Pinto
	<Joao.Pinto@synopsys.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <1482912577-31356-1-git-send-email-kishon@ti.com>
 <20161228092228.GA14025@infradead.org>
 <fa775e80-68cc-0d76-855d-c7e64f8bf1fc@synopsys.com>
 <20161228164118.GB19653@bhelgaas-glaptop.roam.corp.google.com>
 <1ee66ce2-c321-2341-c964-c8b32218ca7e@synopsys.com>
 <426f0cb8-b9d4-7c0d-5eea-0ae0d4b01668@synopsys.com> <5864A335.9000203@ti.com>
 <f2a37587-2e0a-03b3-49d5-3031d453c18c@synopsys.com> <5864F812.5050605@ti.com>
 <1d5f9c4b-b619-36fc-082c-962c34cc3194@synopsys.com> <5864FA60.2070603@ti.com>
 <a6c80508-78ec-b081-3563-275c865275c5@synopsys.com> <5864FF71.4080100@ti.com>
CC: Christoph Hellwig <hch@infradead.org>, Bjorn Helgaas
	<bhelgaas@google.com>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nsekhar@ti.com>, Linus Torvalds
	<torvalds@linux-foundation.org>
From: Joao Pinto <Joao.Pinto@synopsys.com>
Message-ID: <74bba407-9d8f-b274-89b8-8e52a620aff9@synopsys.com>
Date: Thu, 29 Dec 2016 13:19:58 +0000
MIME-Version: 1.0
In-Reply-To: <5864FF71.4080100@ti.com>
Content-Type: text/plain; charset="windows-1252"
List-ID: <linux-pci.vger.kernel.org>


Hi,

Às 12:20 PM de 12/29/2016, Kishon Vijay Abraham I escreveu:
> Hi,
> 
> On Thursday 29 December 2016 05:38 PM, Joao Pinto wrote:
>> Às 11:58 AM de 12/29/2016, Kishon Vijay Abraham I escreveu:
>>> Hi,
>>>
>>> On Thursday 29 December 2016 05:23 PM, Joao Pinto wrote:
>>>> Às 11:48 AM de 12/29/2016, Kishon Vijay Abraham I escreveu:
>>>>> Hi,
>>>>>
>>>>> On Thursday 29 December 2016 04:08 PM, Joao Pinto wrote:
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> Às 5:46 AM de 12/29/2016, Kishon Vijay Abraham I escreveu:
>>>>>>> Hi,
>>>>>>>
>>>>>>> On Wednesday 28 December 2016 10:50 PM, Joao Pinto wrote:
>>>>>>>> Às 5:17 PM de 12/28/2016, Joao Pinto escreveu:
>>>>>>>>> Às 4:41 PM de 12/28/2016, Bjorn Helgaas escreveu:
>>>>>>>>>> On Wed, Dec 28, 2016 at 01:57:13PM +0000, Joao Pinto wrote:
>>>>>>>>>>> Às 9:22 AM de 12/28/2016, Christoph Hellwig escreveu:
>>>>>>>>>>>> On Wed, Dec 28, 2016 at 01:39:37PM +0530, Kishon Vijay Abraham I wrote:
>>>>>>>>>>>>> As discussed during our LPC discussions, I'm posting the rename patch
>>>>>>>>>>>>> here. I'll post the rest of EP series before the next merge window.
>>>>>>>>>>>>>
>>>>>>>>>>>>> There might be hiccups because of this renaming but feel this is
>>>>>>>>>>>>> necessary for long-term maintenance.
>>>>>>>>>>>>
>>>>>>>>>>>> if we do this rename it would be great to get it to Linus NOW after
>>>>>>>>>>>> -rc1 as that minimizes the impact on the 4.11 merge window.
>>>>>>>>>>>
>>>>>>>>>>> Rename it to controller is a bit vague I thing since we have the PCI Endpoint IP
>>>>>>>>>>> also. Wouldn't be better to name it rc_controller?
>>>>>>>>>>
>>>>>>>>>> I think Kishon's whole goal is to add PCI Endpoint IP, so he wants a
>>>>>>>>>> neutral name that can cover both RC and Endpoint.
>>>>>>>
>>>>>>> right.
>>>>>>>>>>
>>>>>>>>>> I'm not a huge fan of "controller" because it feels a little bit long
>>>>>>>>>> and while I suppose it technically does include the concept of the PCI
>>>>>>>>>> interface of an endpoint, it still suggests more of the host side to
>>>>>>>>>> me.
>>>>>>>>>>
>>>>>>>>>> Doesn't USB have a similar situation?  I see there's a
>>>>>>>>>> drivers/usb/host/ (probably where we copied from in the first place).
>>>>>>>>>> Is a USB gadget the USB analog of what you're doing?  How do they
>>>>>>>>>> share code between the master/slave sides?
>>>>>>>>>>
>>>>>>>>>
>>>>>>>>> The usb/host contains the implemnentations by the spec of the several
>>>>>>>>> *hci (USB Host) and then you can have for example the USB 3.0 Designware
>>>>>>>>> Host specific ops in dwc3 and for USB 2.0 in dwc2/.
>>>>>>>
>>>>>>> right, each IP have a separate directory in USB. I thought of doing something
>>>>>>> similar for PCI but decided against it since that would involve identifying all
>>>>>>> the PCI IPs used and eventually result in more directories.
>>>>>>>>> For device purposes it uses the core/ and then some of the device functions
>>>>>>>>> are extended from the gadget/ package in which you can use mass_storage and
>>>>>>>>> other types of functions.
>>>>>>>
>>>>>>> That would be similar for PCI endpoint. All endpoint specific core
>>>>>>> functionality will be added in drivers/pci/endpoint (see RFC [1]).
>>>>>>>>>
>>>>>>>>> In our case in PCI we have the core functions inside /drivers/pci and the host
>>>>>>>>> mangled inside host. I suggest:
>>>>>>>>>
>>>>>>>>> drivers/pci
>>>>>>>>>  drivers/pci/core/
>>>>>>>>>  drivers/pci/core/hotplug
>>>>>>>>>  drivers/pci/core/pcie
>>>>>>>>>  drivers/pci/core/<all other files inside pci/ today>
>>>>>>>>>  drivers/pci/host
>>>>>>>>>  drivers/pci/dwc -> here would be pcie-designware and the specific vendor drivers
>>>>>>>>
>>>>>>>> Correction:
>>>>>>>> drivers/pci/host/dwc -> here would be pcie-designware and the specific vendor
>>>>>>>> drivers
>>>>>>>>
>>>>>>>>>  drivers/pci/<vendorN> -> here would be the drivers for vendorN controller
>>>>>>>>
>>>>>>>> Correction:
>>>>>>>> drivers/pci/host/<vendorN> -> here would be the drivers for vendorN controller
>>>>>>>>
>>>>>>>>>  drivers/pci/endpoint -> common code
>>>>>>>>>  drivers/pci/endpoint/dwc -> implementation of Synopsys specific endpoint ops
>>>>>>>>>  drivers/pci/<vendorN> -> implementation of other vendors specific endpoint ops
>>>>>>>
>>>>>>> There are some parts of the dwc driver that is common to both root complex and
>>>>>>> endpoint. Where should that be? I'm sure no one wants to duplicate the common
>>>>>>> piece in both root complex and endpoint.
>>>>>>
>>>>>> You are right, the config space is almost the same and some ops also common.
>>>>>> I would suggest:
>>>>>>
>>>>>> drivers/pci
>>>>>>   drivers/pci/core/
>>>>>>     drivers/pci/core/hotplug
>>>>>>     drivers/pci/core/pcie
>>>>>>     drivers/pci/core/<all other files inside pci/ today>
>>>>>>   drivers/pci/dwc
>>>>>>     drivers/pci/dwc/common.c -> common ops and registers between RC and endpoint
>>>>>>     drivers/pci/dwc/host/
>>>>>>     drivers/pci/dwc/endpoint/
>>>>>>
>>>>>> What do you think?
>>>>>
>>>>> I don't think we should have sub-directories within dwc (USB too doesn't have
>>>>> sub-directories). Where should the platform specific driver be kept? For
>>>>> example pci-dra7xx.c (which use dwc) has both rc and ep specific parts but the
>>>>> changes are so minimal that splitting the file won't make much sense.
>>>>>
>>>>> And such a change would also mean we create a separate directory for every
>>>>> other driver present right now in pci/host.
>>>>
>>>> I understand you idea. We can simplify it this way:
>>>>
>>>>  drivers/pci
>>>>    drivers/pci/core/
>>>>      drivers/pci/core/hotplug
>>>>      drivers/pci/core/pcie
>>>>      drivers/pci/core/<all other files inside pci/ today>
>>>>      drivers/pci/dwc -> Common files (RC and EP), specific vendor drivers for EP
>>>> and EP
>>>>
>>>> BTW dwc states for DesigWare Controller.
>>>>
>>>> What do you think?
>>>
>>> I'd like to avoid using different directory structures for different IPs. Lets
>>> try to make it uniform.
>>
>> I understand, but mixing them all up is not a good aproach in my opinion, since
>> a SoCs using Synopsys IP will only use the common files for that IP. Today in
>> the host/ folder you have a bunch of drivers that is not clear which are using
>> Synopsys IP or not. Of course I mention Synopsys, because it is where I work,
>> but the opinion would be the same for other IP vendor.
> 
> right, but it has been that way always. My point is why should we disturb it
> for the sake of adding endpoint support.
>>
>> I understand that you want to do a common Endpoint framework to be used by any
>> IP vendor based, and maybe this partition makes it a bit harder, but in my
>> personal opinion each IP vendor should have its own folder for clarity and
>> organization of the code.
>>
>> You framework should be outside those IP vendor folders and be available for
>> their drivers to use it, and so it should be completely vendor agnostic.
> 
> right, that's how it was designed (please see drivers/pci/endpoint/ directories
> in RFC [1] which has the endpoint framework).
> 
> [1] -> https://urldefense.proofpoint.com/v2/url?u=https-3A__lkml.org_lkml_2016_9_14_27&d=DgID-g&c=DPL6_X_6JkXFx7AXWqB0tg&r=s2fO0hii0OGNOv9qQy_HRXy-xAJUD1NNoEcc3io_kx0&m=Usq-eV6vJQ4rVg_Jj-JzgYyH26VfwLaqXDrE_54JCmg&s=wSindfuj1wjD3QeOSzLJNPmgMyqcZNtNX0X-D5yCpqw&e= 

I have checked your patch and seems very useful for certain that I am going to
use to add support a DWC reference Endpoint driver.
Synopsys Endpoint has a DMA engine available that can be used or not by the IP
client. To configure and use it the IP as a set of registers that like other IP
must be configured and managed. Other IP vendors won't have this feature for
sure. So I am saying is, although it gets simpler to have a host/ and a
endpoint/ folder with everything inside, I still feel that we should isolate IP
vendor stuff in isolated ecosystems creating host/dwc and endpoint/dwc where
Synopsys clients can put their drivers and use the common functions. Current
host/ is just a place where every Root Complex driver is deployed. I know it
works of course, but if you are improving structure why not organize it better?
I think that organizing right now would be the perfect timming, in my opinion of
course!

>>
>>>
>>> Thanks
>>> Kishon
>>>
>>
