Return-Path: <jcm@redhat.com>
Return-Path: <jcm@redhat.com>
Content-Type: text/plain;
	charset=us-ascii
From: Jon Masters <jcm@redhat.com>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] PCI: Add PCI device flag PCI_DEV_FLAGS_DMA_ALIAS_ROOT
Message-Id: <E235EFDF-81B0-4A93-8F2D-49065B202581@redhat.com>
Date: Thu, 23 Jun 2016 09:19:29 -0400 (EDT)
References: <linux-pci@vger.kernel.org> <1462700001-30086-1-git-send-email-jchandra@broadcom.com> <5730621B.2050503@arm.com> <CAKc_7PVAV6uAbEFLWHyh1hngLa1PdJxPzk7bPoppexU1oAJHnw@mail.gmail.com> <573340F9.6050507@arm.com> <037404e2-3168-8f99-0bdb-bb929776108e@redhat.com> <576BD031.7090105@arm.com>
To: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <576BD031.7090105@arm.com>
Cc: Jayachandran C <jchandra@broadcom.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        iommu@lists.linux-foundation.org, Bjorn Helgaas <helgaas@kernel.org>,
        linux-pci@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Quick reply (sorry about top post): I am just getting online so I might disc=
over that this callback is shared by both - in which case, cool - but if not=
, we need an interim ACPI solution.

Aside: Current RHEL Server for ARM (RHELSA) explicitly disables SMMUv3 suppo=
rt because (I warned the folks involved more than a year ago), we will only s=
upport ACPI/IORT, and as you can imagine, many people would like us to enabl=
e support for device passthrough and robustness, not to mention 32-bit devic=
es (32-bit DMA mask). Nonetheless, that will only happen when the upstream k=
ernel has IORT and quirks in place.

--=20
Computer Architect | Sent from my 64-bit #ARM Powered phone

> On Jun 23, 2016, at 08:04, Robin Murphy <robin.murphy@arm.com> wrote:
>=20
>> On 23/06/16 06:01, Jon Masters wrote:
>>> On 05/11/2016 10:26 AM, Robin Murphy wrote:
>>> (I have no actual objection to this patch, though, and at this point
>>> I'm just chucking ideas about).
>>=20
>> Can I ask what the next steps are here? We're looking for upstream
>> direction to guide some internal activities and could really do with
>> understanding how you'd like to solve this one longer term as well as
>> what interim solution could be acceptable until we get there.
>=20
> Well, for now I'm planning to leave the explicit "terminate the alias walk=
 from the callback function" behaviour in the DT-parsing code[1], since ther=
e doesn't seem any good reason not to. As Bjorn says, though, it probably is=
 generally useful for the PCI code to have its own knowledge of exactly wher=
e DMA can escape the PCI hierarchy - I now wonder if we could actually just d=
o that from the DT/IORT code; if firmware says a particular bridge/etc. has a=
 relationship with an ITS or SMMU, then presumably it's reasonable to infer t=
hat DMA can come out of it, thus we could inform the PCI code there and then=
 without it having to quirk things on its own?
>=20
> Robin.
>=20
> [1]:http://article.gmane.org/gmane.linux.kernel.iommu/13932
>=20
>>=20
>> Jon.
>=20
