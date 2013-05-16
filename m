Return-Path: <linux-acpi-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <1995989.Fff0uGKnZO@vostro.rjw.lan>
References: <519443A1.8050905@ubuntu.com> <1995989.Fff0uGKnZO@vostro.rjw.lan>
From: Bjorn Helgaas <bhelgaas@google.com>
Date: Thu, 16 May 2013 10:42:03 -0600
Message-ID: <CAErSpo50rX5Pvj=pX5xsdcZ1qq1C7kBqrNyDmY6t26OCVqbxXA@mail.gmail.com>
Subject: Re: enabling aspm on ati radeon
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Phillip Susi <psusi@ubuntu.com>,
	"linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
	Linux PCI <linux-pci@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-acpi-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

On Thu, May 16, 2013 at 2:58 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> [Add linux-pci to the CC]
>
> On Wednesday, May 15, 2013 10:25:37 PM Phillip Susi wrote:
>> -----BEGIN PGP SIGNED MESSAGE-----
>> Hash: SHA1
>>
>> I thought that booting with the pcie_aspm=force option should make
>> sure this was enabled, but passing this to a 3.8.0 kernel, lspci still
>> shows:
>>
>> LnkCap:       Port #0, Speed 5GT/s, Width x16, ASPM L0s L1, Latency L0
>> <64ns, L1 <1us ClockPM- Surprise- LLActRep- BwNot-
>> LnkCtl:       ASPM Disabled; RCB 64 bytes Disabled- Retrain- CommClk+
>> ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
>>
>> What could be disabling ASPM?  dmesg confirms: [    0.000000] PCIe
>> ASPM is forcibly enabled

Can you collect a complete dmesg log and complete "lspci -vv" output, please?

Bjorn
