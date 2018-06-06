Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mail-lf0-f45.google.com ([209.85.215.45]:34929 "EHLO
        mail-lf0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752096AbeFFPsW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Jun 2018 11:48:22 -0400
Received: by mail-lf0-f45.google.com with SMTP id y72-v6so9864668lfd.2
        for <linux-pci@vger.kernel.org>; Wed, 06 Jun 2018 08:48:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHhAz+j=KBFwc10tFCT1mj1dxtR0LhU3TysPz0fFVuDnUOAm-A@mail.gmail.com>
References: <CAHhAz+grcWVZAOvLL9VBHoPLiDCT3LApJTkE7GchtLA3g4U3NA@mail.gmail.com>
 <c8e47c11-e3f5-589f-3a58-4aa2466cac6d@desy.de> <CAHhAz+j=KBFwc10tFCT1mj1dxtR0LhU3TysPz0fFVuDnUOAm-A@mail.gmail.com>
From: Moritz Fischer <moritz.fischer@ettus.com>
Date: Wed, 6 Jun 2018 08:48:20 -0700
Message-ID: <CAAtXAHdrOCkv_jA_nMCMa-2dT=V0006xVNELddjV40TkU+2bhA@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_pcie=3A_fpga=3A_programme_FPGA_PROM=E2=80=99s?=
To: Muni Sekhar <munisekharrms@gmail.com>
Cc: Ludwig Petrosyan <ludwig.petrosyan@desy.de>,
        linux-pci@vger.kernel.org, linux-fpga@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Hi Muni,

On Wed, Jun 6, 2018 at 4:37 AM, Muni Sekhar <munisekharrms@gmail.com> wrote:
> On Wed, Jun 6, 2018 at 4:50 PM, Ludwig Petrosyan
> <ludwig.petrosyan@desy.de> wrote:
>> Hi
>>
>> why You do not use jtagplayer from Xilinx?
>
> Yes, JTAG can be used. But we have a lot many of these FPGA boards,
> using JTAG costs more. And also we want to automate the PROM
> programming.
>
>
>>
>>
>> with best regards
>>
>>
>> Ludwig
>>
>>
>>
>> On 06/06/2018 11:08 AM, Muni Sekhar wrote:
>>>
>>> [ Please keep me in CC as I'm not subscribed to the list]
>>>
>>> Hi All,
>>>
>>> We have a Kintex7 FPGA board connected to Intel Atom PC running Ubuntu
>>> on PCIe bus.

Are you using a Tandem flow? What kind of PROM are we talking about QSPI flash?

Cheers,

Moritz
