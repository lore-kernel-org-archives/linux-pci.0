Return-Path: <SRS0=xjg9=XR=redhat.com=jcm@kernel.org>
Return-Path: <SRS0=xjg9=XR=redhat.com=jcm@kernel.org>
Subject: Re: [PATCH v4 1/1] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe
 controller
To: Duc Dang <dhdang@apm.com>
References: <20161201183350.GF30746@bhelgaas-glaptop.roam.corp.google.com>
 <f18738b7096fb06a5865214ddc299ce99630673b.1480644928.git.dhdang@apm.com>
 <6d593615-e97f-8738-42be-1f8f4906d2f4@redhat.com>
 <CADaLNDkyCrheZLNG3_9BVgvGBW8WrA-VPWOCezz3U-g+nt5W9w@mail.gmail.com>
 <175F32B0-C73F-4250-9E60-3CE7409F0B0C@redhat.com>
 <CADaLNDmWRn+UKzF8PH2LmYCSF+NhHaw26RTN+QoaByh1wS7jfQ@mail.gmail.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Rafael Wysocki <rafael@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Arnd Bergmann
 <arnd@arndb.de>, Mark Salter <msalter@redhat.com>,
        linux-pci@vger.kernel.org,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, patches <patches@apm.com>
From: Jon Masters <jcm@redhat.com>
Message-ID: <c73545ee-07d9-ff40-ba7b-fb84f2382968@redhat.com>
Date: Fri, 2 Dec 2016 14:59:33 -0500
MIME-Version: 1.0
In-Reply-To: <CADaLNDmWRn+UKzF8PH2LmYCSF+NhHaw26RTN+QoaByh1wS7jfQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-pci.vger.kernel.org>

On 12/02/2016 02:39 PM, Duc Dang wrote:
> On Fri, Dec 2, 2016 at 12:11 AM, Jon Masters <jcm@redhat.com> wrote:
>> You're welcome.
>>
>> (Unrelated) Note that I added a console= and earlycon in my test (and got the baud rate wrong for the console but nevermind...was ssh'd in after the earlycon output I cared about anyway) because of some other cleanup work for the SPCR parsing that apparently is still not quite fixed for upstream, or rather, there is a need to match on the 32-bit access required for the UART and that isn't happening so it's not getting setup. Folks are tracking that one and fixing it though.
> 
> I don't see this console issue on X-Gene1 (Mustang board). I tried
> with X-Gene 2 as well. I used both console=ttyS0,115200 and
> earlycon=uart8250,mmio32,0x1c020000. Are you setting baudrate to
> 115200 or something else?

It's an m400 issue in that their SPCR needs updating to convey the
required 32-bit access width for the 8250 dw IP or similar. It's one
of those things someone described the other day and it made sense but
I haven't yet dug into the exact situation, other than that I know
the access width in the m400 ACPI table isn't quite right.

My understanding is that it's in hand. I'll catch up on exactly what's
up, check with my own mustangs, and followup separately.

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
