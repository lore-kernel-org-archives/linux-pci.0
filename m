Return-Path: <linux-kernel-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20150618180103.GA23809@roeck-us.net>
References: <1432342336-25832-1-git-send-email-linux@roeck-us.net>
 <20150527210447.GY32152@google.com> <20150528022332.GA23724@roeck-us.net>
 <20150528124112.GJ10210@google.com> <20150618180103.GA23809@roeck-us.net>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 18 Jun 2015 14:51:52 -0500
Message-ID: <CAErSpo5f4cf7cYZ1WxUQd7soEvNWCHowdNnHTbfGmKh16Vdsrg@mail.gmail.com>
Subject: Re: [PATCH] PCI: Only enable IO window if supported
To: Guenter Roeck <linux@roeck-us.net>
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
	Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, Jun 18, 2015 at 1:01 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> On Thu, May 28, 2015 at 07:41:12AM -0500, Bjorn Helgaas wrote:
>>
>> > > I'd like res->flags to reflect the capabilities of the hardware, not
>> > > whether the window is currently enabled.
>> > >
>> > Flag bits seem to be all taken. Could we use IORESOURCE_DISABLED for that
>> > purpose, or could that cause conflicts elsewhere ?
>>
>> Yes, I think IORESOURCE_DISABLED would be appropriate for any I/O windows
>> below a host bridge that doesn't support I/O space.
>>
> I integrated Lorenzo's patch and tried to get this working.
>
> Problem is that the use of a resource is widely checked with "!res->flags"
> throughout the code. That would have to be changed to something like
> "(!res->flags || (res->flags & IORESOURCE_DISABLED))" whereever it is used.
>
> I tried going with "!res->flags" instead, but have not been able to get it
> to work realiably; it is just very difficult to distinguish if "!res->flags"
> means that the resource has not yet been assigned or if it means that it is not
> supported.
>
> The correct approach, in my opinion, would be to go with IORESOURCE_DISABLED
> and make the necessary changes whereever needed. Effectively this means to
> replace the "!res->flags" check with something like pci_res_used() [ pick
> your preferred name ] and define it as
>
> #define pci_res_used(res) ((res)->flags && !((res)->flags & IORESOURCE_DISABLED))

I think that makes sense.  Maybe "res_valid()"?  It's not really
PCI-specific, and "used" is a little ambiguous.  So is "valid", I
admit.

Bjorn
