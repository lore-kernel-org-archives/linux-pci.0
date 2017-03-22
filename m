Return-Path: <SRS0=hbEj=27=jonmasters.org=jcm@kernel.org>
Return-Path: <SRS0=hbEj=27=jonmasters.org=jcm@kernel.org>
To: David Daney <ddaney@caviumnetworks.com>, Tomasz Nowicki
 <tn@semihalf.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <20170131142525.GA9942@bhelgaas-glaptop.roam.corp.google.com>
 <20170131145720.GA14231@localhost.localdomain>
 <20170131203109.GA14127@bhelgaas-glaptop.roam.corp.google.com>
 <20170201125325.GA15805@localhost.localdomain>
 <20170201151807.GA15793@bhelgaas-glaptop.roam.corp.google.com>
 <376ae1df-da85-e576-75d6-3ae2ab0f1b41@jonmasters.org>
 <20170315113323.GA28027@localhost.localdomain>
 <251db823-591b-483b-9c55-13c911020fd1@jonmasters.org>
 <48b93116-cc0f-e59d-8aa3-704052ad6759@gmail.com>
 <c3392131-9243-24d3-30b4-4d7e84019d6f@jonmasters.org>
 <20170321134744.GA13150@bhelgaas-glaptop.roam.corp.google.com>
 <b50b6a7f-30be-4206-4f38-2539ea936228@semihalf.com>
 <aad5796a-1af8-53e0-c5f3-cb7755519cd5@caviumnetworks.com>
Cc: David Daney <ddaney.cavm@gmail.com>,
 Vadim Lomovtsev <Vadim.Lomovtsev@caviumnetworks.com>,
 David.Daney@cavium.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, stemerkhanov@CAVIUMNETWORKS.onmicrosoft.com,
 bhelgaas@google.com, linux-arm-kernel@lists.infradead.org
From: Jon Masters <jcm@jonmasters.org>
Message-ID: <de830a73-6f01-62af-b454-dc1588a209eb@jonmasters.org>
Date: Wed, 22 Mar 2017 10:28:27 -0400
MIME-Version: 1.0
In-Reply-To: <aad5796a-1af8-53e0-c5f3-cb7755519cd5@caviumnetworks.com>
Content-Type: text/plain; charset=windows-1252
Subject: Re: [PATCH] PCI: ACPI: Fix ThunderX PEM initialization
List-ID: <linux-pci.vger.kernel.org>

On 03/21/2017 10:56 AM, David Daney wrote:
> On 03/21/2017 07:17 AM, Tomasz Nowicki wrote:

>> On 21.03.2017 14:47, Bjorn Helgaas wrote:

>>>> And for other folks following along with this thread: I'm not just
>>>> picking on Cavium here. I'll be doing the same with *every* ARM server
>>>> SoC company as necessary over the coming months.

>>> Thanks for keeping on top of this, Jon.

You're welcome. I'm pleased (in some sense) that we're starting to see
enough systems shipping that unifying quirks and IDs such that ODMs
can bend metal easily is a problem that we want to solve. I am saddened
that there isn't an ARM swat team with black helicopters swooping in to
ensure zoo avoidance (and I do actually request this every year in my
own budget cycle), but I am very "happy" to serve that role for now.

As I said, this isn't Cavium's fault. They're a victim of their market
success. I'm super excited to see them shipping systems on which we
want to run general purpose Operating Systems. At the same time, as
with *every* other ARM vendor, I will keep my eye out for compliance
concerns and I will act to ensure that these things are flagged.

>>> I agree, we should not be
>>> using unregistered vendor prefixes, e.g., the "THRX" added by
>>> 44f22bd91e88 ("PCI: Add MCFG quirks for Cavium ThunderX pass2.x host
>>> controller").  I'm sorry I merged that without doing the due
>>> diligence.

Oh, it's difficult for you to police everything without having every
possible platform in front of you, with every firmware, and a lot of
time that none of us have :)

>> Honestly, it is me who is responsible for this since I submitted
>> the patch.

You're great Tomasz. You've done awesome stuff over the past few months.
I want to be /very/ clear that none of my pushback is directed at you,
David, or any specific individual. You're doing great. I'm going to
make sure that alignment happens in this industry because I need to
ship a "common core" single binary build OS that supports "ARM
servers". That means every server, from every vendor. Not all are
going to be "certified" to run RHEL, but all servers must be capable
of booting and working with upstream kernels, and running *ANY*
Linux distro, so that customers and users who try an "ARM server"
from a random ODM don't get upset. There will be no zoo. There will
only be "upstream first" driven development and the distros will
learn to consume only from upstream. They won't produce hacked up
nonsense with patches to support platforms that aren't upstream.

> Yes.  After all this back and forth, Cavium has decided to deploy
> firmware with "CAVxxx" as _HID.

Great. How about a stable backport for Greg K-H? I want to make sure
that everyone running "upstream" has a chance of booting.

> The deciding factor was that the prefix is already registered and there
> are probably fewer than 10 systems deployed with the experimental and
> erroneous  "THRXxxx" value.  Neither option (switching the kernel to "CAVxxx",
> or changing the firmware to use "THRXxxx") was without its drawbacks. 

Agree. Let's pick a solution and learn for the future. I know you know
this, but for everyone else (especially ARM vendors who follow):

The dirty secret to server is that we have software we ship, and hardware
that ships separately. The software lives for years. It's easier to change
the hardware than software that has already shipped. This is where very
rich and featurefull firmware comes in. The platform is defined by the
firmware, which should provide a fully standard interface that is SET
IN STONE. It's so utterly bulletproof that it's both forward and
backward compatible. Going forward, all of the ARM vendors are going
to have utterly bulletproof server platforms with an amazing level of
joined up cohesion in terms of tracking changes on the software and
hardware side in terms of the platform firmware gluing it together.

It's a dirty secret that x86 teaches us, and we're going to play
exactly the same model out again (this has been the evil plan for
many many years). But to do it right requires that we are very
very careful in connecting dots between the platform pieces.

Thanks,

Jon.
