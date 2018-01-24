Return-Path: <SRS0=is49=ET=gmail.com=myron.stowe@kernel.org>
Return-Path: <SRS0=is49=ET=gmail.com=myron.stowe@kernel.org>
MIME-Version: 1.0
In-Reply-To: <b93a4fb1ec42480596b8d1a2b525e8f1@microsemi.com>
References: <0ce08a91-fc38-1288-7683-836fcbbbdf3c@codeaurora.org>
 <20180119205153.GB160618@bhelgaas-glaptop.roam.corp.google.com>
 <62d57a7c-b45d-3567-4dc6-5b0a0dba046f@codeaurora.org> <20180122213630.GB5317@bhelgaas-glaptop.roam.corp.google.com>
 <1e62a548-cc4c-d93e-6916-8ac695ebfdaa@codeaurora.org> <20180122225127.GC5317@bhelgaas-glaptop.roam.corp.google.com>
 <00b97a2a-981d-f1c7-abcd-b5ee686c5568@codeaurora.org> <20180123001634.GD5317@bhelgaas-glaptop.roam.corp.google.com>
 <09bd3f5c-4671-d9dd-fa39-4d7619ee5860@codeaurora.org> <SHAPR01MB173EFAB42A8838DC3D52FD1FEE30@SHAPR01MB173.CHNPR01.prod.partner.outlook.cn>
 <20180123143839.GE5317@bhelgaas-glaptop.roam.corp.google.com> <b93a4fb1ec42480596b8d1a2b525e8f1@microsemi.com>
From: Myron Stowe <myron.stowe@gmail.com>
Date: Wed, 24 Jan 2018 09:29:45 -0700
Message-ID: <CAL-B5D1bjmOCe3bCwEyq4Mpsaasss4GeL6E2B1RoRhY9uC6_Ew@mail.gmail.com>
Subject: Re: One Question About PCIe BUS Config Type with pcie_bus_safe or
 pcie_bus_perf On NVMe Device
To: Radjendirane Codandaramane <radjendirane.codanda@microsemi.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Ron Yuan <ron.yuan@memblaze.com>,
	Sinan Kaya <okaya@codeaurora.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Bo Chen <bo.chen@memblaze.com>, William Huang <william.huang@memblaze.com>,
	Fengming Wu <fengming.wu@memblaze.com>, Jason Jiang <jason.jiang@microsemi.com>,
	Ramyakanth Edupuganti <Ramyakanth.Edupuganti@microsemi.com>,
	William Cheng <william.cheng@microsemi.com>, "Kim Helper (khelper)" <khelper@micron.com>,
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-pci.vger.kernel.org>

Radjendirane,

I've struggled with a response to your latest posting all
night.  I don't want to come off as offensive or terse as happens all too
often on linux mail lists, all that does is shut things down unnecessarly
without relaying any information that is being sought.

Bjorn is just one person trying to keep up with this entire list.  On this
particular topic he has taken considerable time explaining, and answering
peoples specific questions, as to how Linux currently handles PCIe MPS and
MRRS settings.  As such, it was quite surprising to see your
latest posting as the majority of the content had already
been covered - the exact same questions/points - in great
detail.

We should respect Bjorn's time as much as possible and "do our
homework"; in this specific case, take the time to read the entire thread,
carefully, as that would have circumvented this awkward and frustrating
situation.  If there are still questions on covered topics, then ask the
questions at that point (i.e. use proper response techniques to preserve
context for all; don't just repeat a question much later in the thread that
has already been discussed).

Again, I'm not trying to shut you down.


As Sinan pointed out in the thread's inception:
  "Please use mailing list email syntax moving forward. (inline and 75
  characters per line)".

On Tue, Jan 23, 2018 at 4:50 PM, Radjendirane Codandaramane
<radjendirane.codanda@microsemi.com> wrote:
> Hi Bjorne,

Bjorn

>
> Ceiling the MRRS to the MPS value in order to guarantee the interoperabil=
ity in pcie_bus_perf mode does not make sense. A device can make a memrd re=
quest according to the MRRS setting (which can be higher than its MPS), but=
 the completer has to respect the MPS and send completions accordingly. As =
an example, system can configure MPS=3D128B and MRRS=3D4K, where an endpoin=
t can a make 4K MemRd request, but the completer has to send completions as=
 128B TLPs, by respecting the MPS setting. MRRS does not force a device to =
use higher MPS value than it is configured to.

This was covered by the very first topic in Bjorn's first reply within the
thread...

>
> Another factor that need to be considered for storage devices is that sup=
port of T10 Protection Information (DIF). For every 512B or 4KB, a 8B PI is=
 computed and inserted or verified, which require the 512B of data to arriv=
e in sequence. If the MRRS is < 512B, this might pose out of order completi=
ons to the storage device, if the EP has to submit multiple outstanding rea=
d requests in order to achieve higher performance. This would be a challeng=
e for the storage endpoints that process the T10 PI inline with the transfe=
r, now they have to store and process the 512B sectors once they receive al=
l the TLPs for that sector.

The "T10" aspects are new and I've not heard about them before.  On the
surface they seem to be storage device specific.  If that is indeed the
case then there seems to be some mixing of two, distinctly different,
things.  PCIe TLPs, MPS, MRRS, ..., are all PCIe defined items that are
covered by its specification.  Expecting that T10 specifics can be
intermixed within PCIe's protocol doesn't make any sense and sounds much
more like something that will have to be taken care of at the controller's
level.   Perhaps I'm  way off base here, we'll have to hear more about this
to come to some understanding.

>
> So, it is better to decouple the MRRS and MPS in pcie_bus_perf mode. Like=
 stated earlier in the thread, provide an option to configure MRRS separate=
ly in pcie_bus_perf mode.

This also has been brought up twice already, and covered in the prior
responses...

>
> Regards,
> Radj.
