Return-Path: <SRS0=+rHZ=5S=deltatee.com=logang@kernel.org>
Return-Path: <SRS0=+rHZ=5S=deltatee.com=logang@kernel.org>
To: Alan Cox <alan@linux.intel.com>, Bjorn Helgaas <helgaas@kernel.org>
References: <5933fe2d.V33ODGPU9noDVuyF%fengguang.wu@intel.com>
 <20170606175552.GA12672@bhelgaas-glaptop.roam.corp.google.com>
 <fe0543c1-cba6-02bb-36eb-395910bd5012@deltatee.com>
 <20170612200852.GA28578@bhelgaas-glaptop.roam.corp.google.com>
 <61e11e67-6c1b-ef1e-5fb8-a7c9efb17666@deltatee.com>
 <1497354494.5693.1.camel@linux.intel.com>
Cc: kernel test robot <fengguang.wu@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, LKP <lkp@01.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 wfg@linux.intel.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Arnd Bergmann <arnd@arndb.de>, Linus Walleij <linus.walleij@linaro.org>,
 David Airlie <airlied@linux.ie>, David Herrmann <dh.herrmann@gmail.com>,
 Daniel Vetter <daniel.vetter@ffwll.ch>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <633b81ff-2152-1ac0-cbcf-1fa621abf261@deltatee.com>
Date: Tue, 13 Jun 2017 10:16:44 -0600
MIME-Version: 1.0
In-Reply-To: <1497354494.5693.1.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Subject: Re: [Merge tag 'pci-v4.12-changes' of git] 857f864014: BUG: unable to
 handle kernel NULL pointer dereference at 00000000000000a8
List-ID: <linux-pci.vger.kernel.org>



On 13/06/17 05:48 AM, Alan Cox wrote:
> If you dump the list of majors and drivers do they all look valid or is
> there any corruption or repetition that looks odd (wondering if we've
> got too many devices or a leak) ?

They look valid to me.

Logan


Character devices:
  1 mem
  4 /dev/vc/0
  4 tty
  4 ttyS
  5 /dev/tty
  5 /dev/console
  5 /dev/ptmx
  7 vcs
  9 st
 10 misc
 13 input
 21 sg
 29 fb
 43 ttyI
 45 isdn
 68 capi20
 86 ch
 90 mtd
 99 ppdev
108 ppp
128 ptm
136 pts
152 aoechr
153 spi
161 ircomm
172 ttyMX
174 ttyMI
202 cpu/msr
203 cpu/cpuid
204 ttyJ
204 ttyMAX
206 osst
216 rio_cm
217 cros_ec
218 hidraw
219 ttySDIO
220 uio
221 firewire
222 nvme
223 aac
224 mei
225 phantom
226 drm
227 aux
228 cmx
229 cmm
230 ttySLP
231 ttyIPWp
232 ttySL
233 ttySLM
234 noz
235 ttyS
236 ttyRP
237 ttyARC
238 ttyPS
239 ttyIFX
240 ttySC
241 ipmidev
242 rio_mport
243 xz_dec_test
244 bsg
245 pvfs2-req
246 watchdog
247 iio
248 ptp
249 pps
250 dax
251 dimmctl
252 ndctl
253 tpm
254 gpiochip
