Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20180111190415.3jd4uffpp6weshzf@pd.tnic>
References: <20180111150316.19951-1-Yazen.Ghannam@amd.com> <CAJZ5v0gU6var3gNQsp2GkSujbR=vB2Zj4dZHKNOzfAtC76jFbA@mail.gmail.com>
 <DM5PR12MB191612888094C4794951FAE4F8160@DM5PR12MB1916.namprd12.prod.outlook.com>
 <CAJZ5v0ie_FntO=TO1X_tX9xzz-t6Q_yeWvTfhqufTbYBdwMGJg@mail.gmail.com> <20180111190415.3jd4uffpp6weshzf@pd.tnic>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 12 Jan 2018 01:28:12 +0100
Message-ID: <CAJZ5v0iV_UKkaCoA_jvPLDF-E6roSxJ65+ua5L-xDia-Sa=mAQ@mail.gmail.com>
Subject: Re: [PATCH] PCI/ACPI: Disable AER when _OSC control bit is clear.
To: Borislav Petkov <bp@suse.de>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        "Ghannam, Yazen" <Yazen.Ghannam@amd.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jan 11, 2018 at 8:04 PM, Borislav Petkov <bp@suse.de> wrote:
> On Thu, Jan 11, 2018 at 07:03:23PM +0100, Rafael J. Wysocki wrote:
>> >> > +       if (!(requested & control & OSC_PCI_EXPRESS_AER_CONTROL))
>> >>
>> >> One of the operators above needs to be a && I suppose?
>> >>
>> >
>> > It's a 3-way bitwise AND to check that OSC_PCI_EXPRESS_AER_CONTROL is
>> > set in both "requested" and "control".
>> >
>> > IOW, we check if AER was requested by the OS and that the platform
>> > granted the request.
>>
>> OK
>
> This definitely needs a comment - people will keep tripping over this.

Fair enough.
