Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-yb0-f172.google.com ([209.85.213.172]:35163 "EHLO
        mail-yb0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbdE3S3O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 30 May 2017 14:29:14 -0400
Received: by mail-yb0-f172.google.com with SMTP id r66so16111882yba.2
        for <linux-pci@vger.kernel.org>; Tue, 30 May 2017 11:29:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170530174143.GA27080@bhelgaas-glaptop.roam.corp.google.com>
References: <CA+QBN9ANaDgcTDVeMA45m7gkH65x2OMBaa4y_xg5t4KX7WavZw@mail.gmail.com>
 <20170530174143.GA27080@bhelgaas-glaptop.roam.corp.google.com>
From: Carlo Pisani <carlojpisani@gmail.com>
Date: Tue, 30 May 2017 20:29:12 +0200
Message-ID: <CA+QBN9DPhWbRNJYLEX2fPJ8uiNBEPcrb86UU6W9MScSNb5w-Ww@mail.gmail.com>
Subject: Re: PowerPC405 DHT-Walnut, PCI_IO problems
To: linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

hi
thanks for the answer

> Are you using the same DTS for both 2.6.22 and 4.11?

kernel 2.6.22 doesn't require DTS, it's built with the old uImage
script, whereas Kernels. >= 2.6.26 require a bootwrapper if you want
to boot them with an old uBoot (aka cuImage/cuBoot) which doesn't
support DTS

kernel 2.6.22: mymake-ppc uImage
kernel 4.11.0: mymake-powerpc cuImage.walnut

---------------------------------------------------------------
cat /usr/bin/mymake-ppc
myarch="ppc"
myccandclib="powerpc-unknown-linux-gnu-"
make ARCH=$myarch CROSS_COMPILE=$myccandclib $1 $2 $3 $4 $5 $6 $7
---------------------------------------------------------------
myarch="powerpc"
myccandclib="powerpc-unknown-linux-gnu-"
make ARCH=$myarch CROSS_COMPILE=$myccandclib $1 $2 $3 $4 $5 $6 $7
---------------------------------------------------------------

I didn't add a pci_fixup procedure (it's empty) in
arch/powerpc/boot/cuboot-walnut.c: this module only cares about
setting the MAC of the built-in lan0, and the CPU clock.


/*
 * Old U-boot compatibility for walnut
 * arch/powerpc/boot/cuboot-walnut.c
 */

#define TARGET_4xx

/* -------------------------------------------- */
#include "ops.h"
#include "stdio.h"
/* -------------------------------------------- */
#include "4xx.h"
/* -------------------------------------------- */
#include "cuboot.h"  /* defines cuboot_init */
#include "ppcboot.h" /* defines bd_t */
/* -------------------------------------------- */
#include "dcr.h"
#include "io.h"
/* -------------------------------------------- */

static bd_t bd;
static u8 *walnut_mac0;
struct cs_range
{
    u32 csnum;
    u32 base;     /* must be zero */
    u32 addr;
    u32 size;
};

struct pci_range
{
    u32 flags;
    u32 pci_addr[2];
    u32 phys_addr;
    u32 size[2];
};

struct cs_range  cs_ranges_buf[MAX_PROP_LEN / sizeof(struct cs_range)];
struct pci_range pci_ranges_buf[MAX_PROP_LEN / sizeof(struct pci_range)];

/*
 * Different versions of u-boot
 * might initialize the PCI in a different way
 */
static void update_cs_ranges(void)
{
   /* ? */
}

/*
 * Older u-boots don't set PCI up properly.
 */
static void fixup_pci(void)
{
    /* ? */
    printf("walnut_bootwrapper.fixup_pci: using existing firmware setup\r\n");
}

/* --------------------------------------------------------------- */

static void walnut_flashsel_fixup(void)
{
        void *devp, *sram;
        u32 reg_flash[3] = {0x0, 0x0, 0x80000};
        u32 reg_sram[3] = {0x0, 0x0, 0x80000};
        u8 *fpga;
        u8 fpga_brds1 = 0x0;

        //devp = finddevice("/plb/ebc/fpga");
        //if (!devp)
        //{
        //        fatal("Couldn't locate FPGA node\n\r");
        //}

        if (getprop(devp, "virtual-reg", &fpga, sizeof(fpga)) != sizeof(fpga))
        {
                fatal("no virtual-reg property\n\r");
        }

        fpga_brds1 = in_8(fpga);

        devp = finddevice("/plb/ebc/flash");
        if (!devp)
        {
                fatal("Couldn't locate flash node\n\r");
        }

        if (getprop(devp, "reg", reg_flash, sizeof(reg_flash)) !=
sizeof(reg_flash))
        {
                fatal("flash reg property has unexpected size\n\r");
        }

        sram = finddevice("/plb/ebc/sram");
        if (!sram)
        {
                fatal("Couldn't locate sram node\n\r");
        }

        if (getprop(sram, "reg", reg_sram, sizeof(reg_sram)) !=
sizeof(reg_sram))
        {
                fatal("sram reg property has unexpected size\n\r");
        }

        if (fpga_brds1 & 0x1)
        {
                reg_flash[1] ^= 0x80000;
                reg_sram[1] ^= 0x80000;
        }

        setprop(devp, "reg", reg_flash, sizeof(reg_flash));
        setprop(sram, "reg", reg_sram, sizeof(reg_sram));
}

static void ibm4xx_fixup_pci()
{
        update_cs_ranges();
        fixup_pci();
}

static void walnut_fixups(void)
{
        ibm4xx_sdram_fixup_memsize();
        ibm405gp_fixup_clocks(33330000, 0xa8c000);
        ibm4xx_quiesce_eth((u32 *)0xef600800, NULL);
        ibm4xx_fixup_ebc_ranges("/plb/ebc");
        walnut_flashsel_fixup();
        dt_fixup_mac_address_by_alias("ethernet0", walnut_mac0);
        ibm4xx_fixup_pci();
}

void my_platform_init(void)
{
        unsigned long end_of_ram = 0x2000000;
        unsigned long avail_ram = end_of_ram - (unsigned long) _end;

        simple_alloc_init(_end, avail_ram, 32, 32);
        platform_ops.fixups = walnut_fixups;
        platform_ops.exit   = ibm40x_dbcr_reset;
        fdt_init(_dtb_start);
        serial_console_init();
}

void walnut_init(void *mac0)
{
        platform_ops.fixups = walnut_fixups;
        platform_ops.exit   = ibm40x_dbcr_reset;
        walnut_mac0         = mac0;
        fdt_init(_dtb_start);
        serial_console_init();
}

/* --------------------------------------------------------*/

void platform_init
(
  unsigned long r3,
  unsigned long r4,
  unsigned long r5,
  unsigned long r6,
  unsigned long r7
)
{
        /*
         * CUBOOT_INIT();
         * defined in arch/powerpc/boot/cuboot.h
         */
        memcpy(&bd, (bd_t *)r3, sizeof(bd));
        cuboot_init(r4, r5, r6, r7, bd.bi_memstart + bd.bi_memsize);

        /*
         * walnut init
         */
        walnut_init(&bd.bi_enetaddr);
}
