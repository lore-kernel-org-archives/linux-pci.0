Return-Path: <alexdeucher@gmail.com>
Return-Path: <alexdeucher@gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKb7UvisjzPs_K1SNdDb7aZjxGQL4AOs05R8CX2xjU4uRpfcfA@mail.gmail.com>
References: <20160715131218.2416-1-peter@lekensteyn.nl> <CAKb7UvisjzPs_K1SNdDb7aZjxGQL4AOs05R8CX2xjU4uRpfcfA@mail.gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Fri, 15 Jul 2016 12:27:57 -0400
Message-ID: <CADnq5_OBjHXO4sfakK0ZJPbHPrMACqdU7J-j9sHLjod0QcuzcA@mail.gmail.com>
Subject: Re: [Nouveau] [PATCH v3 0/4] nouveau RPM fixes for Optimus (final)
To: Ilia Mirkin <imirkin@alum.mit.edu>
Cc: Peter Wu <peter@lekensteyn.nl>, Linux PCI <linux-pci@vger.kernel.org>,
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, Bjorn Helgaas <helgaas@kernel.org>,
	"nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>, Dave Airlie <airlied@redhat.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Fri, Jul 15, 2016 at 12:10 PM, Ilia Mirkin <imirkin@alum.mit.edu> wrote:
> On Fri, Jul 15, 2016 at 9:12 AM, Peter Wu <peter@lekensteyn.nl> wrote:
>> Hi,
>>
>> Here are two patches to fix an issue reported on kernel bugzilla (infinite loop
>> due to unchecked function) and a more important fix to fix hanging Optimus
>> machines when runtime PM is enabled (with pm/pci patches).
>>
>> These are the final patches targeting v4.8. Changes compared to v2[1]:
>> collected R-b from Hans and Mika and fixed a minor comment style issue.
>>
>> I recommend it to be merged before the pci/pm patches[2], otherwise there is a
>> window where newer Nvidia Optimus laptops might fail to runtime resume and/or
>> lock up.  Once the pci/pm branch is merged I will propose another patch to
>> improve reliability[3].
>>
>> Known issue with patch 4: when a Nvidia HDMI audio function is present, the
>> bridge will not suspend and hence the Nvidia card will still be powered. Fixing
>
> That's basically all optimus gpu's, right? Anything GT21x+ has a HDMI
> audio subfunction, and prior to that, the nvidia gpu tended to be the
> only gpu, or hard-muxed.

I'd imagine there is a strap on the asic so the audio function is only
enabled if there is a connector actually wired to the dGPU.  It
doesn't make much sense to expose audio if there is no way to use it.

Alex
