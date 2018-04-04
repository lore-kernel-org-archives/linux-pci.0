Return-Path: <SRS0=U4mF=GZ=apm.com=fkan@kernel.org>
Return-Path: <SRS0=U4mF=GZ=apm.com=fkan@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180330225024.GH9322@bhelgaas-glaptop.roam.corp.google.com>
References: <1520274579-30492-1-git-send-email-fkan@apm.com>
 <CAL85gmAAVoCCXoLH+c0ROSBy4mS3z86tnbX+7Avh5oGT=fHcfA@mail.gmail.com> <20180330225024.GH9322@bhelgaas-glaptop.roam.corp.google.com>
From: Feng Kan <fkan@apm.com>
Date: Wed, 4 Apr 2018 14:10:41 -0700
Message-ID: <CAL85gmBtFnXje9tPngXEyCCwuvxvH6YHB=HrvjfU7npPDiSTCw@mail.gmail.com>
Subject: Re: [PATCH V3] PM / core: fix deferred probe breaking suspend resume order
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, linux-arm-kernel@lists.infradead.org,
	Linux PCI <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Toan Le <toanle@apm.com>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Fri, Mar 30, 2018 at 3:50 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Thu, Mar 15, 2018 at 11:41:33AM -0700, Feng Kan wrote:
>> On Mon, Mar 5, 2018 at 10:29 AM, Feng Kan <fkan@apm.com> wrote:
>> > When bridge and its endpoint is enumerated the devices are added to the
>> > dpm list. Afterward, the bridge defers probe when IOMMU is not ready.
>> > This causes the bridge to be moved to the end of the dpm list when
>> > deferred probe kicks in. The order of the dpm list for bridge and
>> > endpoint is reversed.
>> >
>> > Add reordering code to move the bridge and its children and consumers to
>> > the end of the pm list so the order for suspend and resume is not altered.
>> > The code also move device and its children and consumers to the tail of
>> > device_kset list if it is registered.
>> >
>> > Signed-off-by: Feng Kan <fkan@apm.com>
>> > Signed-off-by: Toan Le <toanle@apm.com>
>> > ...
>> >
>> Hi, just wanted to check if there is anything else I need to change on
>> this. Thanks.
>
> I'm assuming Rafael will handle this.
Rafael, sorry to ping again. Do you have a position on this patch yet?
