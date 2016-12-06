Return-Path: <SRS0=DdPg=XV=redhat.com=jcm@kernel.org>
Return-Path: <SRS0=DdPg=XV=redhat.com=jcm@kernel.org>
Subject: Re: [PATCH v3] PCI/ACPI: xgene: Add ECAM quirk for X-Gene PCIe
 controller
To: Bjorn Helgaas <helgaas@kernel.org>
References: <1480549373-2123-1-git-send-email-dhdang@apm.com>
 <20161201183350.GF30746@bhelgaas-glaptop.roam.corp.google.com>
 <1480620053.4751.30.camel@redhat.com>
 <20161201194114.GA8263@bhelgaas-glaptop.roam.corp.google.com>
 <CADaLNDkVPRPSg0aU-sxHsiJbVvEn=LxcekDt6gfXBBhc+fzhjw@mail.gmail.com>
 <20161201230736.GA17948@bhelgaas-glaptop.roam.corp.google.com>
 <CADaLND=Ss8d-jv7wffbrtytrjj=SUnjDn9bognKUszhKguRV1A@mail.gmail.com>
 <d77e403c-81e9-114e-6ec6-bbffaa4ac36f@redhat.com>
 <20161202233943.GF9903@bhelgaas-glaptop.roam.corp.google.com>
 <62dd5462-4d68-b89f-2b45-0d58bbd96bcd@redhat.com>
 <20161205212140.GA18259@bhelgaas-glaptop.roam.corp.google.com>
Cc: Duc Dang <dhdang@apm.com>, Mark Salter <msalter@redhat.com>,
        Rafael Wysocki <rafael@kernel.org>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Arnd Bergmann
 <arnd@arndb.de>, linux-pci@vger.kernel.org,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tomasz Nowicki <tn@semihalf.com>, patches <patches@apm.com>
From: Jon Masters <jcm@redhat.com>
Message-ID: <aac9391d-8803-f5e8-f4e4-d7e56d54c05c@redhat.com>
Date: Tue, 6 Dec 2016 14:46:00 -0500
MIME-Version: 1.0
In-Reply-To: <20161205212140.GA18259@bhelgaas-glaptop.roam.corp.google.com>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-pci.vger.kernel.org>

On 12/05/2016 04:21 PM, Bjorn Helgaas wrote:
> On Fri, Dec 02, 2016 at 07:33:46PM -0500, Jon Masters wrote:

>>> Even without this patch, I don't think it's a show-stopper to have
>>> Linux mistakenly thinking this region is routed to PCI, because the
>>> driver does reserve it and the PCI core will never try to use it.
>>
>> Ok. So are you happy with pulling in Duc's v4 patch and retaining
>> status quo on the bridge resources for 4.10?
> 
> Yes, I think it looks good.  I'll finish packaging things up and
> repost the current series.

Ok, great. So you're still pretty confident we'll have "out of the box"
booting on these machines for 4.10? :)

Jon.

-- 
Computer Architect | Sent from my Fedora powered laptop
