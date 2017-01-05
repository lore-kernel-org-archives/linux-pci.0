Return-Path: <SRS0=GKof=YT=xilinx.com=bharatku@kernel.org>
Return-Path: <SRS0=GKof=YT=xilinx.com=bharatku@kernel.org>
From: Bharat Kumar Gogada <bharat.kumar.gogada@xilinx.com>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Marc Zyngier <marc.zyngier@arm.com>, Bjorn Helgaas <helgaas@kernel.org>,
	"arnd@arndb.de" <arnd@arndb.de>
Subject: Need information on handling legacy interrupts
Date: Thu, 5 Jan 2017 14:40:12 +0000
Message-ID: <8520D5D51A55D047800579B094147198263B5640@XAP-PVEXMBX02.xlnx.xilinx.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-pci.vger.kernel.org>

Hi,

In pcie-xilinx-nwl.c, the bridge has legacy status read only register where=
 the status bit is set when
Assert_INTx is received and cleared only when Deassert_INTx is received.
The above scenario is causing issue if an EP takes more time to send Deasse=
rt_Intx (we are mainly seeing issue
with wifi cards, when we do wifi scan and not with other cards, where we te=
sted Ethernet/nvme).
Here is code in driver:

chained_irq_enter(chip, desc);
        pcie =3D irq_desc_get_handler_data(desc);

        while ((status =3D nwl_bridge_readl(pcie, MSGF_LEG_STATUS) &
                                MSGF_LEG_SR_MASKALL) !=3D 0) {
                for_each_set_bit(bit, &status, INTX_NUM) {
                        virq =3D irq_find_mapping(pcie->legacy_irq_domain,
                                                bit + 1);
                        if (virq)
                                generic_handle_irq(virq);
                }
        }
chained_irq_exit(chip, desc);

So the RP driver will continuously loop in the while as there is delay in E=
P Deassert_Intx, this is leading to CPU stall.
so we tried changing from "while" to "if", to avoid looping in while,  but =
since legacy IRQ line is
high (level sensitive GIC again sees as new interrupt)  the RP handler is c=
alled continuously again not
giving cpu share to execute other tasks leading to CPU stall.

In case of pcie-xilinx.c where the the bridge is different, when IDR regist=
er is cleared at the end of interrupt handler, the
irq line between RP and GIC goes low. In this scenario the same wifi cards =
works fine.

In other drivers (altera, keystone) I see that they have a register where t=
hey acknowledge the bridge after
they receive legacy interrupt, but not sure whether it makes irq line low.

So which is the better way to handle legacy interrupts, whether to wait for=
 deassert or whether to
acknowledge bridge after receiving interrupt irrespective of Deassert and m=
ake irq line low?

Thanks & Regards,
Bharat



This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.
