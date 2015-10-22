Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <56295FAE.5040108@ti.com>
Date: Thu, 22 Oct 2015 18:14:06 -0400
From: Murali Karicheri <m-karicheri2@ti.com>
MIME-Version: 1.0
To: Russell King - ARM Linux <linux@arm.linux.org.uk>, <lho@apm.com>,
	KISHON VIJAY <kishon@ti.com>, <alexandre.torgue@st.com>
CC: WingMan Kwok <w-kwok2@ti.com>, <robh+dt@kernel.org>,
	<pawel.moll@arm.com>, <mark.rutland@arm.com>,
	<ijc+devicetree@hellion.org.uk>, <galak@codeaurora.org>,
	<rogerq@ti.com>, <bhelgaas@google.com>, <ssantosh@kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 0/2] Common SerDes driver for TI's Keystone Platforms
References: <1445432201-16007-1-git-send-email-w-kwok2@ti.com> <5628FB36.4010303@ti.com> <20151022174812.GX32532@n2100.arm.linux.org.uk> <56295B9E.9030201@ti.com>
In-Reply-To: <56295B9E.9030201@ti.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

+ Alexandre Torgue <alexandre.torgue@st.com> (Owner of phy-miphy28lp.c)
+ Loc Ho <lho@apm.com> (Owner of phy-miphy28lp.c)

On 10/22/2015 05:56 PM, Murali Karicheri wrote:
> On 10/22/2015 01:48 PM, Russell King - ARM Linux wrote:
>> On Thu, Oct 22, 2015 at 11:05:26AM -0400, Murali Karicheri wrote:
>>> On 10/21/2015 08:56 AM, WingMan Kwok wrote:
>>>> On TI's Keystone platforms, several peripherals such as the
>>>> gbe ethernet switch, 10gbe ethernet switch and PCIe controller
>>>> require the use of a SerDes for converting SoC parallel data into
>>>> serialized data that can be output over a high-speed electrical
>>>> interface, and also converting high-speed serial input data
>>>> into parallel data that can be processed by the SoC.  The
>>>> SerDeses used by those peripherals, though they may be different,
>>>> are largely similar in functionality and setup.
> ------------Cut-------------------------------------------------
>>>>
>>>>   Documentation/devicetree/bindings/phy/ti-phy.txt |  239 +++
>>>>   drivers/pci/host/pci-keystone.c                  |   24 +-
>>>>   drivers/pci/host/pci-keystone.h                  |    1 +
>>>>   drivers/phy/Kconfig                              |    8 +
>>>>   drivers/phy/Makefile                             |    1 +
>>>>   drivers/phy/phy-keystone-serdes.c                | 2366
>>>> ++++++++++++++++++++++
>>>>   6 files changed, 2629 insertions(+), 10 deletions(-)
>>>>   create mode 100644 drivers/phy/phy-keystone-serdes.c
>>>>
>>> Kishon, Bjorn
>>>
>>> Who will pick this up? Do we have time to get this in 4.4?
>>
>> I've been avoiding this since my initial comments, but if you're wanting
>> to get it into v4.4, then I have to say something.
> Russell,
>
> I saw you have raised this point earlier against v1 of the patch series.
> I have responded as below  (cut-n-pasted from that email)
>
> "The serdes on K2 are re-used on multiple hardware blocks as already
> indicated in this thread. It has got multiple lanes, each lane can be
> enabled/disabled, shutdown etc. Isn't generic phy framework added to
> support this type of hardware block? I see some enhancements needed for
> K2 serdes to support monitoring the serdes link and providing a status
> to the higher layer device. So I am not clear what different way you
> would like to handle serdes drivers? Why do you need a new framework?
> "
>
> KISHON VIJAY had responded saying
>
> "The PHY framework (in drivers/phy/) already provides a standard
> interface to be used by the controller drivers no?"
>
> But I have not seen your response to these questions from us. v2 and v3
> has gone by and since all of the outstanding comments have been
> addressed and you have not responded to our questions, I thought this
> can be merged for 4.4. Good to see you have responded now :)
>>
>> Again, there's other SoCs out there which have serdes.  Adding 2.5k of
>> lines for vendor serdes implementations does not scale - this needs to
>> be re-thought in a way which reduces the code maintanence burden.
>>
>> Other SoCs like Marvell Armada have serdes links which can be configured
>> between SATA, PCIe and Gbe.  Should Armada end up adding another 2.5k
>> lines to support their device too?  What happens when we have 10 of
>> these, and we have 25k lines of code here?
>>
>> Again, this does not scale.  Please look at what can be done to reduce
>> the code size when other implementations come along.
>
> Well, per our understanding, this driver is a Generic phy driver and we
> have implemented a device driver based on Generic Phy API. This driver
> is expected to support all of the 3 peripherals :- PCIe, 1G and 10G
> Ethernet.  You have mentioned about Marvell & Armada . Did Marvell post
> any patch already? Without seeing their code, how will we be able to
> investigate what can be factored out to a generic serdes core driver? By
> making this statement, I assume you are still considering using the
> Generic Phy driver framework for SerDes drivers. Don't you?
>
> I did a search in the phy folder and these are the top ones that came
> out in terms of number of lines of code after Phy-core.c.
>
> ls *.[ch] | xargs wc -l | sort -n
>
>     943 phy-core.c
>    1279 phy-miphy28lp.c
>    1735 phy-xgene.c
>    2367 phy-keystone-serdes.c
>
> So focusing on the top 3 drivers (including keystone serdes) under phy.
>
> phy-xgene.c
> -----------
>
> Looking at other drivers under drivers/phy, I could find phy-xgene.c
> which is close Keystone SerDes driver (. This is called APM X-Gene
> Multi-Purpose PHY driver. It defines following mode per the driver code
>
>          MODE_SATA       = 0,    /* List them for simple reference */
>          MODE_SGMII      = 1,
>          MODE_PCIE       = 2,
>          MODE_USB        = 3,
>          MODE_XFI        = 4,
>
> But seems to support only MODE_SATA. From the code, it appears, this
> driver is expected to be enhanced in the future to support additional
> modes. I have copied the author to this email to participate in this
> discussion.
>
> Keystone SerDes supports following modes
> ----------------------------------------
>      KSERDES_PHY_SGMII,
>      KSERDES_PHY_XGE,
>      KSERDES_PHY_PCIE,
>      KSERDES_PHY_HYPERLINK,
>      KSERDES_PHY_SRIO
>
> And phy-miphy28lp.c
> ---------------------
>
> +#define PHY_TYPE_SATA          1
> +#define PHY_TYPE_PCIE          2
> +#define PHY_TYPE_USB2          3
> +#define PHY_TYPE_USB3          4
>
> Keystone SerDes hardware is highly parameterized. The init has following
> steps:-
>    - Configure the Phy to one of the mode (SATA,SGMII,PCIE,USB,XFI)
>    - Configure the Phy to the specific mode
>    - Configure N lanes for the selected mode
>    - Enable N Lanes
>
> So at a high level, I can imagine these kind of Phys require additionally
>
>    - Enable/Disable Lane
>    - check lane status periodically
>
> So there is a scope for enhancing the Phy core API to handle these kinds
> of phy ops. This might help to re-use some code. But at the lower level
> driver, we still need to write to vendor specific registers and
> configure the SerDes which is the major part of the driver and that
> still will be a major part of these drivers.
>
> I would also like to hear from Kishon (Maintainer) on his ideas for
> Generic Phy driver to support these kind of SerDes hardwares.
>
> I think it is fair to ask to merge the Keystone SerDes driver right now
> as we have spend considerable time reviewing the current series and
> taken care of all other outstanding comments. We are most happy to
> enhance the Phy core framework to help re-use code across the above and
> future SerDes driver that supports multiple modes.
>
> Or do you have some other ideas that you would like to share?
>
> Murali
>
>>
>> (I am aware that guys working on Marvell Armada are looking into this
>> problem - but I know they're ready to post anything yet.)
>>
>
>


-- 
Murali Karicheri
Linux Kernel, Keystone
