Return-Path: <SRS0=Xauo=5S=oracle.com=james.puthukattukaran@kernel.org>
Return-Path: <SRS0=Xauo=5S=oracle.com=james.puthukattukaran@kernel.org>
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v3] PCI: Workaround wrong flags completions for IDT switch
From: James Puthukattukaran <james.puthukattukaran@oracle.com>
In-Reply-To: <20170613221451.GC7012@bhelgaas-glaptop.roam.corp.google.com>
Date: Tue, 13 Jun 2017 19:19:57 -0400
Cc: Yinghai Lu <yinghai@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-Id: <4E27D271-80C3-4EED-860C-936AC1CCCD2F@oracle.com>
References: <20170609231617.20243-1-yinghai@kernel.org> <20170612214848.GC28578@bhelgaas-glaptop.roam.corp.google.com> <CAE9FiQU_Hfsn-_tJSQ2NbqMV-rtaiFsX1FWfe_fADbd8TnKhBA@mail.gmail.com> <8e04aa73-8fe0-d1ac-208b-3f8fa4b04c4b@oracle.com> <20170613221451.GC7012@bhelgaas-glaptop.roam.corp.google.com>
To: Bjorn Helgaas <helgaas@kernel.org>
List-ID: <linux-pci.vger.kernel.org>



> On Jun 13, 2017, at 6:14 PM, Bjorn Helgaas <helgaas@kernel.org> wrote:
>=20
>> On Tue, Jun 13, 2017 at 02:30:55PM -0400, james puthukattukaran wrote:
>>> On 6/13/2017 1:00 PM, Yinghai Lu wrote:
>>>> On Mon, Jun 12, 2017 at 2:48 PM, Bjorn Helgaas <helgaas@kernel.org> wro=
te:
>>>>> On Fri, Jun 09, 2017 at 04:16:17PM -0700, Yinghai Lu wrote:
>>>>> From: James Puthukattukaran <james.puthukattukaran@oracle.com>
>>>>>=20
>>>>> The IDT switch incorrectly flags an ACS source violation on a read con=
fig
>>>>> request to an end point device on the completion (IDT 89H32H8G3-YC,
>>>>> errata #36) even though the PCI Express spec states that completions a=
re
>>>>> never affected by ACS source violation (PCI Spec 3.1, Section 6.12.1.1=
).
>>>> Can you include a URL where this erratum is published?  If not, can
>>>> you include the actual erratum text here?
>>> Ok.
>>=20
>> Here's the errata text
>> ------------------------------------
>> Item #36 - Downstream port applies ACS Source Validation to Completions
>> =E2=80=9CSection 6.12.1.1" of the PCI Express Base Specification 3.1 stat=
es
>> that completions are never affected
>> by ACS Source Validation. However, completions received by a
>> downstream port of the PCIe switch from a device that has not yet
>> captured a PCIe bus number are incorrectly dropped by ACS source
>> validation by the switch downstream port.
>>=20
>> Workaround: Issue a CfgWr1 to the downstream device before issuing
>> the first CfgRd1 to the device.
>> This allows the downstream device to capture its bus number; ACS
>> source validation no longer stops
>> completions from being forwarded by the downstream port. It has been
>> observed that Microsoft Windows implements this workaround already;
>> however, some versions of Linux and other operating systems may not.
>=20
> This doesn't mention anything about disabling ACS.  Issuing a config
> write to devices downstream of an IDT bridge sounds simpler than what
> this patch does.  Why don't you do that?

The issue is how will we know is the config write succeeds if the device is n=
ot ready? I thought it was simpler to disable acs for the sake of the read a=
nd when we know that the device is ready ( returns vendor id from read), it'=
s ready for subsequent config write.=20

>=20
> This patch does write to PCI_VENDOR_ID, which purports to be part of
> the workaround, but that happens *after* the first config read (which
> happens inside __pci_bus_read_dev_vendor_id()).
>=20
> Bjorn
