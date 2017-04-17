Return-Path: <SRS0=6Kxz=3Z=google.com=bhelgaas@kernel.org>
Return-Path: <SRS0=6Kxz=3Z=google.com=bhelgaas@kernel.org>
MIME-Version: 1.0
In-Reply-To: <66168dde-7719-6f74-3f06-8e4724dd2918@codeaurora.org>
References: <1491627351-1111-1-git-send-email-okaya@codeaurora.org>
 <1491627351-1111-5-git-send-email-okaya@codeaurora.org> <CACK8Z6GXfMWxakNQnvMToig9z9McnJKeYFc2BAAFy7ys8=PUWg@mail.gmail.com>
 <d3857812-7e03-4b62-f7cb-ac0d139b6123@codeaurora.org> <20170414214452.GA21870@bhelgaas-glaptop.roam.corp.google.com>
 <66168dde-7719-6f74-3f06-8e4724dd2918@codeaurora.org>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Mon, 17 Apr 2017 11:38:21 -0500
Message-ID: <CAErSpo7p_2dTDTC7J4HdQUw_5GH8081dUZ=XVqd=sRLrA_FJnA@mail.gmail.com>
Subject: Re: [PATCH V8 4/5] PCI/ASPM: save power on values during bridge init
To: Sinan Kaya <okaya@codeaurora.org>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Rajat Jain <rajatja@google.com>,
	"Patel, Mayurkumar" <mayurkumar.patel@intel.com>, Rajat Jain <rajatxjain@gmail.com>,
	David Daney <david.daney@cavium.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Timur Tabi <timur@codeaurora.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Julia Lawall <Julia.Lawall@lip6.fr>,
	linux-arm-msm <linux-arm-msm@vger.kernel.org>, Yinghai Lu <yinghai@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>, linux-arm <linux-arm-kernel@lists.infradead.org>,
	Myron Stowe <myron.stowe@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Fri, Apr 14, 2017 at 5:17 PM, Sinan Kaya <okaya@codeaurora.org> wrote:
> On 4/14/2017 5:44 PM, Bjorn Helgaas wrote:
>> I think there's an argument to be made that if we care about ASPM
>> configuration, we should be using a non-POLICY_DEFAULT setting.  And I
>> think there's value in having POLICY_DEFAULT be the absolute lowest-
>> risk setting, which I think means option 1.
>>
>> What do you think?
>
> I see your point. The counter argument is that most of the users do not
> know what an ASPM kernel command line is unless they understand PCI
> language.

I don't think the answer is using the "pcie_aspm.policy=" boot
argument.  I certainly don't want users to have to deal with that.  I
wish we didn't even have that parameter.

I think we need runtime knobs instead (and I guess we already have
/sys/module/pcie_aspm/parameters/policy and /sys/.../link_state), and
distro userspace should use them.  I'm envisioning something in
"System Settings / Power" or similar.  Basically I think the policy
doesn't *have* to be dictated by a kernel boot-time parameter, so it
should not be.

> I have been using the powersave policy option until now. I recently realized
> that nobody except me is using this option. Therefore, we are wasting
> power by default following a hotplug insertion.
>
> This is the case where I'm trying to avoid. With the introduction of NVMe
> u.2 drives, hotplug is becoming more and more mainstream. I decided to
> take the matters into my hand with this series for this very reason.
>
> Like you said, BIOS is out of the picture with pciehp. There is nobody
> to configure ASPM following a hotplug insertion.
>
> I can also claim that If user wants performance, they should boot with
> the performance policy or pcie_aspm=off parameters.
>
> I saw this recommendation in multiple DPDK tuning documents.
>
> Like you said, what do we do by default is the question. Should we opt
> for safe like we are doing, or try to save some power.

I think safety is paramount.  Every user should be able to boot safely
without any kernel parameters.  We don't want users to have a problem
booting and then have to search for a workaround like booting with
"pcie_aspm=off".  Most users will never do that.

Here's a long-term strawman proposal, see what you think:

  - Deprecate CONFIG_PCIEASPM_DEFAULT, CONFIG_PCIEASPM_POWERSAVE, etc.
  - Default aspm_policy is POLICY_DEFAULT always.
  - POLICY_DEFAULT means Linux doesn't touch anything: if BIOS enabled
ASPM, we leave it that way; we leave ASPM disabled on hot-added
devices.
  - Deprecate kernel boot parameters (possibly keep pcie_aspm=off for
debugging use).
  - Use /sys/module/pcie_aspm/parameters/policy for run-time
system-wide  control, including for future hot-added devices.
  - Remove CONFIG_PCIEASPM_DEBUG and enable that code always, so we
have fine-grained run-time control.

> Maybe, we are missing a HPP option from the PCI spec.

That's an interesting idea.  _HPX does have provision for manipulating
Link Control bits (see ACPI r5.0, sec 6.2.8.3), but I don't think very
many systems implement it.  And there's currently no connection
between program_hpp_type2() and aspm.c, so I'm a little worried that
we might have issues if a system did implement an _HPX that sets any
of the ASPM bits.

Bjorn
