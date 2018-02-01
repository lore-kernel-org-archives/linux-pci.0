Return-Path: <SRS0=fng+=E3=gmail.com=myron.stowe@kernel.org>
Return-Path: <SRS0=fng+=E3=gmail.com=myron.stowe@kernel.org>
MIME-Version: 1.0
In-Reply-To: <SHAPR01MB173F9910CA9B2651104E319FEFB0@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
References: <62d57a7c-b45d-3567-4dc6-5b0a0dba046f@codeaurora.org>
 <20180122213630.GB5317@bhelgaas-glaptop.roam.corp.google.com>
 <1e62a548-cc4c-d93e-6916-8ac695ebfdaa@codeaurora.org> <20180122225127.GC5317@bhelgaas-glaptop.roam.corp.google.com>
 <00b97a2a-981d-f1c7-abcd-b5ee686c5568@codeaurora.org> <20180123001634.GD5317@bhelgaas-glaptop.roam.corp.google.com>
 <09bd3f5c-4671-d9dd-fa39-4d7619ee5860@codeaurora.org> <SHAPR01MB173EFAB42A8838DC3D52FD1FEE30@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
 <20180123143839.GE5317@bhelgaas-glaptop.roam.corp.google.com>
 <b93a4fb1ec42480596b8d1a2b525e8f1@microsemi.com> <20180124180118.GJ5317@bhelgaas-glaptop.roam.corp.google.com>
 <SHAPR01MB173F9910CA9B2651104E319FEFB0@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
From: Myron Stowe <myron.stowe@gmail.com>
Date: Wed, 31 Jan 2018 17:01:47 -0700
Message-ID: <CAL-B5D3rbY57UNANUcuguHy1X4CzhCSpGk0i9i-13RHEo9NQ6Q@mail.gmail.com>
Subject: Re: One Question About PCIe BUS Config Type with pcie_bus_safe or
 pcie_bus_perf On NVMe Device
To: Ron Yuan <ron.yuan@memblaze.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>,
	Radjendirane Codandaramane <radjendirane.codanda@microsemi.com>, Sinan Kaya <okaya@codeaurora.org>,
	Bjorn Helgaas <bhelgaas@google.com>, Bo Chen <bo.chen@memblaze.com>,
	William Huang <william.huang@memblaze.com>, Fengming Wu <fengming.wu@memblaze.com>,
	Jason Jiang <jason.jiang@microsemi.com>,
	Ramyakanth Edupuganti <Ramyakanth.Edupuganti@microsemi.com>,
	William Cheng <william.cheng@microsemi.com>, "Kim Helper (khelper)" <khelper@micron.com>,
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

On Wed, Jan 31, 2018 at 1:40 AM, Ron Yuan <ron.yuan@memblaze.com> wrote:
> Hi, I would like to provide more information just for anyone who might be=
 interested.
> We modify FW to simulate a MPS 128 capability SSD, and experiment with di=
fferent pcis_bus mode on Dell R730XD, hence we can have a better look at th=
e whole picture.
>
> First, cold boot with single SSD
> device:  Slot (C 256)     SSD (C 128B)  Slot (C 256B)   SSD (C 256B)
>         MPS  MRRS    MPS  MRRS   MPS MRRS       MPS MRRS
> Normal  128     128          128        4096
> Normal                                  256     128            256      4=
096
> Perf        256 128          128        128
> Perf                                            256     128        256  2=
56
> Safe            128     128          128        4096
> Safe                                            256     128            25=
6      4096
>
> Then cold boot with two devices, different MPS capability=EF=BC=8C both s=
lots are directly connect to CPU
> device:  slot (C 256)     SSD (C 128B)     Slot (C 256B)     SSD (C 256B)
>         MPS  MRRS    MPS  MRRS      MPS MRRS       MPS MRRS
> Normal  128     128          128        4096    256  128       256  4096
> Perf     256    128          128        128         256  128       256  2=
56
> Safe    128     128          128        4096    256  128       256  4096
>
> Finally, to match Sinan's example, we use a PCIe switch for two U.2 SSD:
> \-[0000:00]-+-00.0
>              +-01.0-[03]----00.0
>              +-02.0-[04]--
>              +-03.0-[02]--+-00.0
>              |            \-00.1
>              +-03.1-[01]--+-00.0
>              |            \-00.1
>              +-03.2-[05-0a]----00.0-[06-0a]--+-04.0-[07]--
>              |                               +-05.0-[08]----00.0    -> co=
nnect a 256B ssd
>              |                               +-06.0-[09]----00.0    -> co=
nnect a 128B ssd
>
>                 00.03.2 (C 256)  05:00.0 (C512) 06:05.0 (C512)    08:00.0=
 (SSD C256=EF=BC=8906:06.0 (C512)      09:00.0 (SSD C128)
>                 MPS     MRRS     MPS    MRRS    MPS     MRRS     MPS    M=
RRS    MPS MRRS        MPS     MRRS
> Normal  128     128          128        128         128 128          128 =
       4096    128     128         128 4096
> Perf            256     128      256    128         256 128          256 =
       256         256 128         128 128
> Safe            128     128          128        128         128 128      =
    128        4096    128     128         128 4096
>
> I think from above examples:
> 1. perf mode is moving devices to 256 MPS as it can.
> 2. safe mode is setting to 128 MPS
> 3. perf mode set MRRS=3DMPS is a CORRECT call for device with MPSC lower =
than its parents.
> 4. perf mode set MRRS=3DMPS is not necessary for a device with SAME MPSC =
as its parents?
> 5. it is an interested point to me that slot/switch/root MRRS are always =
set to 128B, I have not found out why.

In Sinan's original posting, a reference to
https://www.xilinx.com/support/documentation/white_papers/wp350.pdf
was provided.  When I read that paper and got to the "Read Completion
Boundary" section I thought to myself: "If RCB can only be 64 or 128
bytes then what's the point of MPS (or MRRS) as all TLP completions
would be limited to 64 or 128 bytes? (see also the paper's 'Read
Completions with the RCB Set to 64 Bytes' figure)".  I brought this up
to a colleague and they surmised that possibly only _lower end_
(a.k.a. lazy) chipset implementations would truly have RCB limited
sized completions; higher end chipsets would of course have to comply
with RCB when communicating with the memory controller but could then
aggregate data into larger MPS (or MRRS) sized TLP completion packets.
Perhaps this might explain why you always saw slot/switch/root values
set at 128B?

>
> Again, thanks for everyone's time on this subject. We have learnt a lot.
>
> Ron
