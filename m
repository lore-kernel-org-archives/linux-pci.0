Return-Path: <myron.stowe@gmail.com>
Return-Path: <myron.stowe@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20161121165352.GM25762@bhelgaas-glaptop.roam.corp.google.com>
References: <20161102223552.14776-1-jthumshirn@suse.de> <20161102223552.14776-2-jthumshirn@suse.de>
 <20161116181158.GB26600@bhelgaas-glaptop.roam.corp.google.com> <20161121165352.GM25762@bhelgaas-glaptop.roam.corp.google.com>
From: Myron Stowe <myron.stowe@gmail.com>
Date: Tue, 22 Nov 2016 09:01:40 -0700
Message-ID: <CAL-B5D0Y30-YYSgAOF_mpaiXp0mv63jQB_311AB4r55m01+vLA@mail.gmail.com>
Subject: Re: [PATCH 2/2] pci: Don't set RCB bit in LNKCTL if the upstream
 bridge hasn't
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Johannes Thumshirn <jthumshirn@suse.de>, Bjorn Helgaas <bhelgaas@google.com>,
	linux-pci <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	Alexander Graf <agraf@suse.de>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-pci.vger.kernel.org>

On Mon, Nov 21, 2016 at 9:53 AM, Bjorn Helgaas <helgaas@kernel.org> wrote:
> On Wed, Nov 16, 2016 at 12:11:58PM -0600, Bjorn Helgaas wrote:
>> Hi Johannes,
>>
>> On Wed, Nov 02, 2016 at 04:35:52PM -0600, Johannes Thumshirn wrote:
>> > The Read Completion Boundary (RCB) bit must only be set on a device or
>> > endpoint if it is set on the root complex.
>>
>> I propose the following slightly modified patch.  The interesting
>> difference is that your patch only touches the _HPX "OR" mask, so it
>> refrains from *setting* RCB in some cases, but it never actually
>> *clears* it.  The only time we clear RCB is when the _HPX "AND" mask
>> has RCB =3D=3D 0.
>>
>> My intent below is that we completely ignore the _HPX RCB bits, and we
>> set an Endpoint's RCB if and only if the Root Port's RCB is set.
>>
>> I made an ugly ASCII table to think about the cases:
>>
>>       Root   EP    _HPX  _HPX     Final Endpoint RCB state
>>       Port  (init)  AND   OR     (curr)  (yours)  (mine)
>>   0)   0     0      0    0          0       0       0
>>   1)   0     0      0    1          1       0       0
>>   2)   0     0      1    0          0       0       0
>>   3)   0     0      1    1          1       0       0
>>   4)   0     1      0    0          0       0       0
>>   5)   0     1      0    1          1       0       0
>>   6)   0     1      1    0          1       1       0
>>   7)   0     1      1    1          1       1       0
>>   8)   1     0      0    0          0       0       1
>>   9)   1     0      0    1          1       1       1
>>   A)   1     0      1    0          0       0       1
>>   B)   1     0      1    1          1       1       1
>>   C)   1     1      0    0          0       0       1
>>   D)   1     1      0    1          1       1       1
>>   E)   1     1      1    0          1       1       1
>>   F)   1     1      1    1          1       1       1
>>
>> Cases 0-7 should all result in the Endpoint RCB being zero because the
>> Root Port RCB is zero.  Case 1 is the bug you're fixing.  Cases 3 & 5
>> are similar hypothetical bugs your patch also fixes.
>>
>> Cases 6 & 7, where firmware left the Endpoint RCB set and _HPX didn't
>> tell us to clear it, are hypothetical firmware bugs that your patch
>> wouldn't fix.
>>
>> In cases 8, A, and C, we currently leave the Endpoint RCB cleared,
>> either because firmware left it clear and _HPX didn't tell us to set
>> it (8 and A), or because firmware set it but _HPX told us to clear it
>> (C).
>>
>> One could argue that 8, A, and C should stay as they currently are, as
>> a way for _HPX to work around hardware bugs, e.g., a Root Port that
>> advertises a 128-byte RCB but doesn't actually support it.  I didn't
>> bother with that and set the Endpoint's RCB to 128 in all cases when
>> the Root Port claims to support it.
>>
>> It'd be great if you could test this and comment.
>>
>> If you get a chance, collect the /proc/iomem contents, too.  That's
>> not for this bug; it's because I'm curious about the
>>
>>   ERST: Can not request [mem 0xb928b000-0xb928cbff] for ERST
>>
>> problem in your dmesg log.
>
> Oops, I goofed and forgot to clear RCB by default.
> Here's the fixed one.
>

Testing on our end was successful again with this fix  ;)

Tested-by: Frank Danapfel <fdanapfe@redhat.com>
Acked-by: Myron Stowe <myron.stowe@redhat.com>

>
> commit b7bff74c2e6babf12906291ee177f16444de81ad
> Author: Johannes Thumshirn <jthumshirn@suse.de>
> Date:   Wed Nov 16 15:47:53 2016 -0600
>
>     PCI: Set Read Completion Boundary to 128 iff Root Port supports it
>
>     Per PCIe spec r3.0, sec 2.3.1.1, the Read Completion Boundary (RCB)
>     determines the naturally aligned address boundaries on which a Read R=
equest
>     may be serviced with multiple Completions:
>
>       - For a Root Complex, RCB is 64 bytes or 128 bytes
>         This value is reported in the Link Control Register
>
>         Note: Bridges and Endpoints may implement a corresponding command=
 bit
>         which may be set by system software to indicate the RCB value for=
 the
>         Root Complex, allowing the Bridge/Endpoint to optimize its behavi=
or
>         when the Root Complex=E2=80=99s RCB is 128 bytes.
>
>       - For all other system elements, RCB is 128 bytes
>
>     Per sec 7.8.7, if a Root Port only supports a 64-byte RCB, the RCB of=
 all
>     downstream devices must be clear, indicating an RCB of 64 bytes.  If =
the
>     Root Port supports a 128-byte RCB, we may optionally set the RCB of
>     downstream devices so they know they can generate larger Completions.
>
>     Some BIOSes supply an _HPX that tells us to set RCB, even though the =
Root
>     Port doesn't have RCB set, which may lead to Malformed TLP errors if =
the
>     Endpoint generates completions larger than the Root Port can handle.
>
>     The IBM x3850 X6 with BIOS version -[A8E120CUS-1.30]- 08/22/2016 supp=
lies
>     such an _HPX and a Mellanox MT27500 ConnectX-3 device fails to initia=
lize:
>
>       mlx4_core 0000:41:00.0: command 0xfff timed out (go bit not cleared=
)
>       mlx4_core 0000:41:00.0: device is going to be reset
>       mlx4_core 0000:41:00.0: Failed to obtain HW semaphore, aborting
>       mlx4_core 0000:41:00.0: Fail to reset HCA
>       ------------[ cut here ]------------
>       kernel BUG at drivers/net/ethernet/mellanox/mlx4/catas.c:193!
>
>     After 6cd33649fa83 ("PCI: Add pci_configure_device() during enumerati=
on")
>     and 7a1562d4f2d0 ("PCI: Apply _HPX Link Control settings to all devic=
es
>     with a link"), we apply _HPX settings to *all* devices, not just thos=
e
>     hot-added after boot.
>
>     Before 7a1562d4f2d0, we didn't touch the Mellanox RCB, and the device
>     worked.  After 7a1562d4f2d0, we set its RCB to 128, and it failed.
>
>     Set the RCB to 128 iff the Root Port supports a 128-byte RCB.  Otherw=
ise,
>     set RCB to 64 bytes.  This effectively ignores what _HPX tells us abo=
ut
>     RCB.
>
>     [bhelgaas: changelog, clear RCB if not set for Root Port]
>     Fixes: 6cd33649fa83 ("PCI: Add pci_configure_device() during enumerat=
ion")
>     Fixes: 7a1562d4f2d0 ("PCI: Apply _HPX Link Control settings to all de=
vices with a link")
>     Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D187781
>     Signed-off-by: Johannes Thumshirn <jthumshirn@suse.de>
>     Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
>     CC: stable@vger.kernel.org  # v3.18+
>
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index ab00267..104c46d 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1439,6 +1439,21 @@ static void program_hpp_type1(struct pci_dev *dev,=
 struct hpp_type1 *hpp)
>                 dev_warn(&dev->dev, "PCI-X settings not supported\n");
>  }
>
> +static bool pcie_root_rcb_set(struct pci_dev *dev)
> +{
> +       struct pci_dev *rp =3D pcie_find_root_port(dev);
> +       u16 lnkctl;
> +
> +       if (!rp)
> +               return false;
> +
> +       pcie_capability_read_word(rp, PCI_EXP_LNKCTL, &lnkctl);
> +       if (lnkctl & PCI_EXP_LNKCTL_RCB)
> +               return true;
> +
> +       return false;
> +}
> +
>  static void program_hpp_type2(struct pci_dev *dev, struct hpp_type2 *hpp=
)
>  {
>         int pos;
> @@ -1468,9 +1483,20 @@ static void program_hpp_type2(struct pci_dev *dev,=
 struct hpp_type2 *hpp)
>                         ~hpp->pci_exp_devctl_and, hpp->pci_exp_devctl_or)=
;
>
>         /* Initialize Link Control Register */
> -       if (pcie_cap_has_lnkctl(dev))
> +       if (pcie_cap_has_lnkctl(dev)) {
> +
> +               /*
> +                * If the Root Port supports Read Completion Boundary of
> +                * 128, set RCB to 128.  Otherwise, clear it.
> +                */
> +               hpp->pci_exp_lnkctl_and |=3D PCI_EXP_LNKCTL_RCB;
> +               hpp->pci_exp_lnkctl_or &=3D ~PCI_EXP_LNKCTL_RCB;
> +               if (pcie_root_rcb_set(dev))
> +                       hpp->pci_exp_lnkctl_or |=3D PCI_EXP_LNKCTL_RCB;
> +
>                 pcie_capability_clear_and_set_word(dev, PCI_EXP_LNKCTL,
>                         ~hpp->pci_exp_lnkctl_and, hpp->pci_exp_lnkctl_or)=
;
> +       }
>
>         /* Find Advanced Error Reporting Enhanced Capability */
>         pos =3D pci_find_ext_capability(dev, PCI_EXT_CAP_ID_ERR);
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
