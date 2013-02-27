Return-Path: <linux-pci-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:23832 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760416Ab3B0Q4w convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pci@vger.kernel.org>); Wed, 27 Feb 2013 11:56:52 -0500
From: "Ronciak, John" <john.ronciak@intel.com>
To: ratheesh kannoth <ratheesh.ksz@gmail.com>
CC: "e1000-devel@lists.sourceforge.net"
	<e1000-devel@lists.sourceforge.net>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: RE: [E1000-devel] pcie error
Date: Wed, 27 Feb 2013 16:56:47 +0000
Message-ID: <D38E8E86660E514AB505863C19C9287C6A459212@ORSMSX101.amr.corp.intel.com>
References: <CAGZFCEFFPqVZ29e7_Bm_Xehw50W-D8K2B=CaXs6VkyDKQmCTvw@mail.gmail.com>
	<D38E8E86660E514AB505863C19C9287C6A458067@ORSMSX101.amr.corp.intel.com>
	<CAGZFCEGu+0Vpn6_KOoRgteBDgm-BHrKvQ3X_fUJVCt_ZD9KY9Q@mail.gmail.com>
	<D38E8E86660E514AB505863C19C9287C6A4580E4@ORSMSX101.amr.corp.intel.com>
 <CAGZFCEGHFLfemJU=hM8odYGuev-as7gXpkjeBvQ2ijX29m5f+w@mail.gmail.com>
In-Reply-To: <CAGZFCEGHFLfemJU=hM8odYGuev-as7gXpkjeBvQ2ijX29m5f+w@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
List-ID: <linux-pci.vger.kernel.org>

Are both NIC's new?  They are of the same family so maybe the "10e6" NIC was somehow damaged.  If that NIC is the only card having problem in that exact slot it would guess that it's that NIC that is bad.

Cheers,
John


> -----Original Message-----
> From: ratheesh kannoth [mailto:ratheesh.ksz@gmail.com]
> Sent: Wednesday, February 27, 2013 8:51 AM
> To: Ronciak, John
> Cc: e1000-devel@lists.sourceforge.net; linux-pci@vger.kernel.org
> Subject: Re: [E1000-devel] pcie error
> 
> On Wed, Feb 27, 2013 at 10:07 PM, Ronciak, John
> <john.ronciak@intel.com> wrote:
> > Looks like you have a HW problem.  Is this a new motherboard?
> Something you built? Can you take out all the devices from the system
> (possibly using the BIOS to m/b based devices) and see if the problem
> is still happening?
> 
> This is a new motherboard. But we have tried a similar pci express nic
> card of 8086:10c9. But it works fine. But when we try with nic of
> 8086:10e6 ,  this problem happens.
> 
> the pci express error gets propagated to root node ? and fails there ?.
> 
> Which hw is having problem ? the pci card or mother board ? how can i
> conclude ?
> 
> 
> Thanks
> 
> 
> 
> >> -----Original Message-----
> >> From: ratheesh kannoth [mailto:ratheesh.ksz@gmail.com]
> >> Sent: Wednesday, February 27, 2013 8:30 AM
> >> To: Ronciak, John
> >> Cc: e1000-devel@lists.sourceforge.net; linux-pci@vger.kernel.org
> >> Subject: Re: [E1000-devel] pcie error
> >>
> >> Hi John,
> >>
> >> Thanks a lot for your reply.
> >>
> >> I have added a pci-express nic card in the pci -express system slot
> .
> >> This nic card is 8086:10e6 based. I could see the error when i send
> >> traffic thru this port and kernel panic. when i looked at
> >> /var/log/messages , i could see
> >>
> >> aer_isr_one_error->can't find device of ID0000
> >> aer_isr_one_error->can't find device of ID0000
> >> aer_isr_one_error->can't find device of ID0000 aer_isr_one_error-
> >can't find device of ID0000 .....
> >> ....
> >> +------ PCI-Express Device Error ------+
> >> Error Severity          : Uncorrected (Non-Fatal)
> >> PCIE Bus Error type     : Transaction Layer
> >> Completion Timeout      : Multiple
> >> Requester ID            : 0028
> >> VendorID=8086h, DeviceID=d13ah, Bus=00h, Device=05h, Function=00h
> >> igb: ge1_0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
> >> igb: ge1_1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control: RX/TX
> >>
> >>
> >>
> >>
> >> [ kernel panic console message ]
> >>
> >> HARDWARE ERROR
> >> CPU 7: Machine Check Exception:                4 Bank 8:
> >> 0000000000000000
> >> TSC 0
> >> This is not a software problem!
> >> Run through mcelog --ascii to decode and contact your hardware
> vendor
> >> Kernel panic - not syncing: Machine check ------------[ cut here
> >> ]------------
> >> WARNING: at kernel/smp.c:329 smp_call_function_many+0x40/0x1e5()
> >> Hardware name: 342?  Modules linked in: nf_conntrack_ipv4
> >> nf_defrag_ipv4 xt_state nf_conntrack xt_tcpudp iptable_filter
> >> ip_tables x_tables bnx2 e100 mii igb_cids ixgbe_cids e1000_cids
> >> cids_shared bpctl_mod cidmodcap cpp_base(P) linux_user_bde(P)
> >> linux_kernel_bde(P)
> >> Pid: 3491, comm: sensorApp Tainted: P           2.6.29.1 #14
> >> Call Trace:
> >> <#MC>  [<ffffffff8023a34f>] warn_slowpath+0xd3/0x10f
> >> [<ffffffff80220733>] ? default_spin_lock_flags+0x9/0xe
> >> [<ffffffff8023aa9a>] ? release_console_sem+0x199/0x1ce
> >> [<ffffffff8050dff7>] ? printk+0x67/0x70  [<ffffffff80220733>] ?
> >> default_spin_lock_flags+0x9/0xe  [<ffffffff8025827f>]
> >> smp_call_function_many+0x40/0x1e5  [<ffffffff80211507>] ?
> >> stop_this_cpu+0x0/0x2c  [<ffffffff8023aa9a>] ?
> >> release_console_sem+0x199/0x1ce  [<ffffffff80258444>]
> >> smp_call_function+0x20/0x24  [<ffffffff8021b37a>]
> >> native_smp_send_stop+0x22/0x49  [<ffffffff8050dee6>]
> panic+0xa8/0x152
> >> [<ffffffff8023a4b7>] ? oops_enter+0xe/0x10  [<ffffffff805112dc>] ?
> >> oops_begin+0x7e/0x8c  [<ffffffff80216da4>] ? print_mce+0xe8/0xec
> >> [<ffffffff80216e15>] mce_log+0x0/0x7f  [<ffffffff802171d7>]
> >> do_machine_check+0x302/0x3d7  [<ffffffff8051076b>]
> >> machine_check+0x1b/0x20  <<EOE>> <4>---[ end trace 877905393052419b
> >> ]---
> >> Rebooting in 1 seconds..
> >>
> >>
> >> 1. is there any way to narrow down the system error ?
> >> 2. any clue or hint is really appreciated.
> >>
> >> -Ratheesh
> >>
> >>
> >> On Wed, Feb 27, 2013 at 9:48 PM, Ronciak, John
> >> <john.ronciak@intel.com>
> >> wrote:
> >> > The "d13a" device is not a networking device.  So I'm not sure
> what
> >> you cut from the logs but the igb messages have nothing to do with
> >> this device.  According to the Device ID's repository the "d13a"
> >> device is a "Core Processor PCI Express Root Port 3".
> >> >
> >> > So this isn't a networking device error but some sort of system
> >> error.
> >> >
> >> > Cheers,
> >> > John
> >> >
> >> >
> >> >> -----Original Message-----
> >> >> From: ratheesh kannoth [mailto:ratheesh.ksz@gmail.com]
> >> >> Sent: Wednesday, February 27, 2013 2:40 AM
> >> >> To: e1000-devel@lists.sourceforge.net; linux-pci@vger.kernel.org
> >> >> Subject: [E1000-devel] pcie error
> >> >>
> >> >> I am getting  an error when i send traffic thru 8086:10e6 device
> >> >>
> >> >> +------ PCI-Express Device Error ------+
> >> >> Error Severity          : Uncorrected (Non-Fatal)
> >> >> PCIE Bus Error type     : Transaction Layer
> >> >> Completion Timeout      : Multiple
> >> >> Requester ID            : 0028
> >> >> VendorID=8086h, DeviceID=d13ah, Bus=00h, Device=05h, Function=00h
> >> >> igb: ge1_0 NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
> >> >> RX/TX
> >> >> igb: ge1_1 NIC Link is Up 1000 Mbps Full Duplex, Flow Control:
> >> >> RX/TX
> >> >>
> >> >> I have added output of lspci -m and  lspci -vvt .
> >> >>
> >> >> 1. How can we confirm this is s/w or hw problem ?
> >> >> 2. Any clue or hint on how to debug is really appreciated  ?
> >> >>
> >> >>
> >> >> bash-3.2# lspci -m
> >> >> 00:00.0 "Class 0600" "Vendor 8086" "Device d130" -r11 "Unknown
> >> vendor
> >> >> 105b" "Device 0d61"
> >> >> 00:03.0 "Class 0604" "Vendor 8086" "Device d138" -r11 "" ""
> >> >> 00:05.0 "Class 0604" "Vendor 8086" "Device d13a" -r11 "" ""
> >> >> 00:08.0 "Class 0880" "Vendor 8086" "Device d155" -r11 "Unknown
> >> vendor
> >> >> 005b" "Device 0061"
> >> >> 00:08.1 "Class 0880" "Vendor 8086" "Device d156" -r11 "Unknown
> >> vendor
> >> >> 005b" "Device 0061"
> >> >> 00:08.2 "Class 0880" "Vendor 8086" "Device d157" -r11 "Unknown
> >> vendor
> >> >> 005b" "Device 0061"
> >> >> 00:08.3 "Class 0880" "Vendor 8086" "Device d158" -r11 "Unknown
> >> vendor
> >> >> 005b" "Device 0061"
> >> >> 00:10.0 "Class 0880" "Vendor 8086" "Device d150" -r11 "Unknown
> >> vendor
> >> >> 005b" "Device 0061"
> >> >> 00:10.1 "Class 0880" "Vendor 8086" "Device d151" -r11 "Unknown
> >> vendor
> >> >> 005b" "Device 0061"
> >> >> 00:1a.0 "Class 0c03" "Vendor 8086" "Device 3b3c" -r06 -p20
> >> >> "Unknown vendor 105b" "Device 0d61"
> >> >> 00:1c.0 "Class 0604" "Vendor 8086" "Device 3b42" -r06 "" ""
> >> >> 00:1c.4 "Class 0604" "Vendor 8086" "Device 3b4a" -r06 "" ""
> >> >> 00:1c.5 "Class 0604" "Vendor 8086" "Device 3b4c" -r06 "" ""
> >> >> 00:1d.0 "Class 0c03" "Vendor 8086" "Device 3b34" -r06 -p20
> >> >> "Unknown vendor 105b" "Device 0d61"
> >> >> 00:1e.0 "Class 0604" "Vendor 8086" "Device 244e" -ra6 -p01 "" ""
> >> >> 00:1f.0 "Class 0601" "Vendor 8086" "Device 3b16" -r06 "Unknown
> >> vendor
> >> >> 105b" "Device 0d61"
> >> >> 00:1f.2 "Class 0104" "Vendor 8086" "Device 2822" -r06 "Unknown
> >> vendor
> >> >> 105b" "Device 0d61"
> >> >> 00:1f.3 "Class 0c05" "Vendor 8086" "Device 3b30" -r06 "Unknown
> >> vendor
> >> >> 105b" "Device 0d61"
> >> >> 01:00.0 "Class 0604" "Vendor 10b5" "Device 8618" -rba "" ""
> >> >> 02:01.0 "Class 0604" "Vendor 10b5" "Device 8618" -rba "" ""
> >> >> 02:03.0 "Class 0604" "Vendor 10b5" "Device 8618" -rba "" ""
> >> >> 02:05.0 "Class 0604" "Vendor 10b5" "Device 8618" -rba "" ""
> >> >> 02:07.0 "Class 0604" "Vendor 10b5" "Device 8618" -rba "" ""
> >> >> 02:09.0 "Class 0604" "Vendor 10b5" "Device 8618" -rba "" ""
> >> >> 02:0b.0 "Class 0604" "Vendor 10b5" "Device 8618" -rba "" ""
> >> >> 02:0d.0 "Class 0604" "Vendor 10b5" "Device 8618" -rba "" ""
> >> >> 02:0f.0 "Class 0604" "Vendor 10b5" "Device 8618" -rba "" ""
> >> >> 03:00.0 "Class 0200" "Vendor 8086" "Device 10d3" "Unknown vendor
> >> 8086"
> >> >> "Device 0000"
> >> >> 04:00.0 "Class 0200" "Vendor 8086" "Device 10d3" "Unknown vendor
> >> 8086"
> >> >> "Device 0000"
> >> >> 05:00.0 "Class 0200" "Vendor 8086" "Device 10d3" "Unknown vendor
> >> 8086"
> >> >> "Device 0000"
> >> >> 06:00.0 "Class 0200" "Vendor 8086" "Device 10d3" "Unknown vendor
> >> 8086"
> >> >> "Device 0000"
> >> >> 07:00.0 "Class 0200" "Vendor 8086" "Device 10d3" "Unknown vendor
> >> 8086"
> >> >> "Device 0000"
> >> >> 08:00.0 "Class 0200" "Vendor 8086" "Device 10d3" "Unknown vendor
> >> 8086"
> >> >> "Device 0000"
> >> >> 09:00.0 "Class 0200" "Vendor 8086" "Device 10d3" "Unknown vendor
> >> 8086"
> >> >> "Device 0000"
> >> >> 0a:00.0 "Class 0200" "Vendor 8086" "Device 10d3" "Unknown vendor
> >> 8086"
> >> >> "Device 0000"
> >> >> 0b:00.0 "Class 0604" "Vendor 10b5" "Device 8624" -rbb "" ""
> >> >> 0c:04.0 "Class 0604" "Vendor 10b5" "Device 8624" -rbb "" ""
> >> >> 0c:05.0 "Class 0604" "Vendor 10b5" "Device 8624" -rbb "" ""
> >> >> 0c:08.0 "Class 0604" "Vendor 10b5" "Device 8624" -rbb "" ""
> >> >> 0c:09.0 "Class 0604" "Vendor 10b5" "Device 8624" -rbb "" ""
> >> >> 0e:00.0 "Class 0604" "Vendor 10b5" "Device 8518" -rac "" ""
> >> >> 0f:01.0 "Class 0604" "Vendor 10b5" "Device 8518" -rac "" ""
> >> >> 0f:02.0 "Class 0604" "Vendor 10b5" "Device 8518" -rac "" ""
> >> >> 10:00.0 "Class 0200" "Vendor 8086" "Device 10e6" -r01 "Unknown
> >> vendor
> >> >> 1374" "Device 0b60"
> >> >> 10:00.1 "Class 0200" "Vendor 8086" "Device 10e6" -r01 "Unknown
> >> vendor
> >> >> 1374" "Device 0b60"
> >> >> 11:00.0 "Class 0200" "Vendor 8086" "Device 10e6" -r01 "Unknown
> >> vendor
> >> >> 1374" "Device 0b60"
> >> >> 11:00.1 "Class 0200" "Vendor 8086" "Device 10e6" -r01 "Unknown
> >> vendor
> >> >> 1374" "Device 0b60"
> >> >> 12:00.0 "Class 0b40" "Vendor 1000" "Device 0a05" -r01 "Unknown
> >> vendor
> >> >> 1000" "Device 0a09"
> >> >> 14:00.0 "Class 1000" "Vendor 177d" "Device 0010" -r01 "Unknown
> >> vendor
> >> >> 177d" "Device 0001"
> >> >> 15:00.0 "Class 0200" "Vendor 8086" "Device 10d3" "Unknown vendor
> >> 8086"
> >> >> "Device 0000"
> >> >> 16:00.0 "Class 0604" "Vendor 1a03" "Device 1150" -r02 "" ""
> >> >> 17:00.0 "Class 0300" "Vendor 1a03" "Device 2000" -r10 "Unknown
> >> vendor
> >> >> 1a03" "Device 2000"
> >> >>
> >> >>
> >> >> bash-3.2# lspci -tvv
> >> >> -[0000:00]-+-00.0  Device 8086:d130
> >> >>
> >> >> +-03.0-[0000:01-0a]----00.0-[0000:02-0a]--+-01.0-[0000:03]--
> >> >> --00.0
> >> >>  Device 8086:10d3
> >> >>            |
> >> >> +-03.0-[0000:04]----00.0  Device 8086:10d3
> >> >>            |
> >> >> +-05.0-[0000:05]----00.0  Device 8086:10d3
> >> >>            |
> >> >> +-07.0-[0000:06]----00.0  Device 8086:10d3
> >> >>            |
> >> >> +-09.0-[0000:07]----00.0  Device 8086:10d3
> >> >>            |
> >> >> +-0b.0-[0000:08]----00.0  Device 8086:10d3
> >> >>            |
> >> >> +-0d.0-[0000:09]----00.0  Device 8086:10d3
> >> >>            |
> >> >> \-0f.0-[0000:0a]----00.0  Device 8086:10d3
> >> >>            +-05.0-[0000:0b-13]----00.0-[0000:0c-13]--+-04.0-
> >> [0000:0d]--
> >> >>            |
> >> >> +-05.0-[0000:0e-11]----00.0-[0000:0f-11]--+-01.0-[0000:10]--+-
> 00.0
> >> >> Device 8086:10e6
> >> >>            |                                         |
> >> >>                         |                 \-00.1  Device
> 8086:10e6
> >> >>            |                                         |
> >> >>                         \-02.0-[0000:11]--+-00.0  Device
> 8086:10e6
> >> >>            |                                         |
> >> >>                                           \-00.1  Device
> 8086:10e6
> >> >>            |
> >> >> +-08.0-[0000:12]----00.0  Device 1000:0a05
> >> >>            |                                         \-09.0-
> >> [0000:13]--
> >> >>            +-08.0  Device 8086:d155
> >> >>            +-08.1  Device 8086:d156
> >> >>            +-08.2  Device 8086:d157
> >> >>            +-08.3  Device 8086:d158
> >> >>            +-10.0  Device 8086:d150
> >> >>            +-10.1  Device 8086:d151
> >> >>            +-1a.0  Device 8086:3b3c
> >> >>            +-1c.0-[0000:14]----00.0  Device 177d:0010
> >> >>            +-1c.4-[0000:15]----00.0  Device 8086:10d3
> >> >>            +-1c.5-[0000:16-17]----00.0-[0000:17]----00.0  Device
> >> >> 1a03:2000
> >> >>            +-1d.0  Device 8086:3b34
> >> >>            +-1e.0-[0000:18]--
> >> >>            +-1f.0  Device 8086:3b16
> >> >>            +-1f.2  Device 8086:2822
> >> >>            \-1f.3  Device 8086:3b30
> >> >>
> >> >>
> >> >> Thanks,
> >> >> Ratheesh
> >> >>
> >> >> -----------------------------------------------------------------
> -
> >> >> --
> >> -
> >> >> --
> >> >> -------
> >> >> Everyone hates slow websites. So do we.
> >> >> Make your web apps faster with AppDynamics Download AppDynamics
> >> >> Lite for free today:
> >> >> http://p.sf.net/sfu/appdyn_d2d_feb
> >> >> _______________________________________________
> >> >> E1000-devel mailing list
> >> >> E1000-devel@lists.sourceforge.net
> >> >> https://lists.sourceforge.net/lists/listinfo/e1000-devel
> >> >> To learn more about Intel&#174; Ethernet, visit
> >> >> http://communities.intel.com/community/wired
